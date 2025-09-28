title 'Azure - test OpenAI resource'

# load data from Terraform output
content = inspec.profile.file('terraform-output.json')
params = JSON.parse(content)

OPENAI_RG = params['resource_group_name']['value']
OPENAI_NAME = params['name']['value']

control 'test-azure-openai' do
  impact 0.8
  title 'Ensure Azure OpenAi resource exists'
  desc 'Fail when the resource doesnt exist'
  describe azure_generic_resource(resource_group: OPENAI_RG, name: OPENAI_NAME, resource_provider: 'Microsoft.CognitiveServices/accounts') do
    it { should exist }
  end
end

# control 'test-azure-openai-pep' do
#   impact 0.8
#   title 'Ensure Azure private endpoint exist'
#   desc 'Fail when the private endpoint doesnt exist'
#   # DATA_DISKS.each do |disk|
#   #   describe azure_virtual_machine_disks(resource_group: DISK_RG_NAME).where(attached: true).where(name: disk) do
#   #     it { should exist }
#   #   end
#   # end
# end
