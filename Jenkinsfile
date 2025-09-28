pipeline {
  agent any

  options {
    ansiColor('xterm')
    buildDiscarder(logRotator(numToKeepStr: '10'))
    disableConcurrentBuilds()
  }

  environment {
    INSPEC_IMAGE_NAME = "5519/inspec-jenkins-agent:4.0.0"
    TERRAFORM_IMAGE_NAME = "5519/terraform-jenkins-agent:1.11.2"
  }

  stages {
    stage('Load IAC Shared Library') {
      steps {
        script {
          configFileProvider([configFile(fileId: 'context.json', variable: 'CONTEXT_FILE')]) {
            def contextContent = readJSON file: env.CONTEXT_FILE
            def toolStackId = contextContent.tool_stack.configs["cloud-aws"].id
            
            withCredentials([usernameColonPassword(credentialsId: toolStackId, variable: 'USERPASS')]) {
              library identifier: 'helpers@v3.0.2',
                retriever: modernSCM([
                  $class: 'GitSCMSource',
                  remote: 'https://git.bnc.ca/scm/iac/jenkins-shared-libraries.git',
                  credentialsId: toolStackId
                ])
            }
          }
        }
      }
    }

    stage('Setup Terraform Execution Environment') {
      steps {
        script {
          context.useToolStack('cloud-aws')
          tf = terraform(cloud_kind: "azure")
          tf.setExecutionEnvironment(
            container.docker()
              .setImage(TERRAFORM_IMAGE_NAME)
              .setRegistry(context.getDockerRegistry("production"))
              .setRegistryCredentials(context.getToolId("artifact-management"))
              .setExtraRunArgs('--entrypoint "" -e DOCKER_HOST=\$DOCKER_HOST')
          )
        }
      }
    }

    stage('Running Tests') {
      when {
        expression { context.shouldBeValidated() }
      }
      environment {
        VAULT_ADDR = "https://vault.bnc.ca"
        VAULT_SKIP_VERIFY = "true"
        VAULT_TOKEN = credentials('vault-token')
      }
      steps {
        script {
          tf.init(workingDirectory: 'examples/simple-example', stage: 'development', subStage: 'dev')
          tf.checkfmt()
          tf.validate()
        }
      }
    }

    stage('Validating') {
      parallel {
        stage('Checking HCL Format and structure') {
          steps {
            script {
              tf.init(workingDirectory: 'examples/simple-example', stage: 'development', subStage: 'dev')
              tf.checkfmt()
              tf.validate()
            }
          }
        }
        stage('Checking documentation') {
          steps {
            container.inside(TERRAFORM_IMAGE_NAME) {
              sh 'terraform-docs --output-check .'
            }
          }
        }
        stage('Checking Terraform Module Structure') {
          environment {
            BITBUCKET_CREDS = credentials('bitbucket-credentials')
          }
          steps {
            container.inside(TERRAFORM_IMAGE_NAME) {
              sh 'rubocop .'
              sh 'inspec exec https://$BITBUCKET_CREDS@git.bnc.ca/iac/inspec-terraform-module-structure.git'
            }
          }
        }
      }
    }

    stage('Applying Terraform configuration for full example') {
      steps {
        script {
          tf.init(workingDirectory: 'examples/full-example', stage: 'development', subStage: 'dev')
          tf.apply()
        }
      }
    }

    stage('Exporting Terraform outputs to inspec profile') {
      steps {
        script {
          tf.output('--json >../../tests/files/terraform-output.json')
        }
      }
    }

    stage('Verifying Terraform configuration') {
      steps {
        container.inside(INSPEC_IMAGE_NAME) {
          credentials.azure().load()
          sh 'inspec exec tests --no-create-lockfile -t azure://'
        }
        post {
          always {
            script {
              tf.destroy()
            }
          }
        }
      }
    }

    stage('Tagging') {
      steps {
        script {
          if(context.shouldBeValidated()) version.gitTag('--dry-run')
          if(BRANCH_NAME == 'master') version.gitTag('--no-fail')
        }
      }
    }
  }
}
