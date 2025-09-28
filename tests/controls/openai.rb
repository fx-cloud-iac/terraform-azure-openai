title 'Azure - test OpenAI resource'

# Load terraform outputs
terraform_outputs = json(File.read('../../files/terraform-output.json'))

OPENAI_RG = terraform_outputs['resource_group_name']['value']
OPENAI_NAME = terraform_outputs['name']['value']

control 'test-azure-openai' do
  impact 0.8
  title 'Ensure OpenAI resource exists'
  desc 'Fail when the resource doesnt exist'

  describe azure_generic_resource(resource_group: OPENAI_RG, name: OPENAI_NAME) do
    it { should exist }
  end
end

#control 'test-azure-openai-pep' do
#  impact 0.8
#  title 'Ensure OpenAI private endpoint exists'
#  desc 'Fail when the private endpoint doesnt exist'
#
#  describe azure_virtual_machine_disks(resource_group: OPENAI_RG) do
#    it { should exist }
#  end
#end
