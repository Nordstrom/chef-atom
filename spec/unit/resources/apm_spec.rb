RSpec.describe 'atom_test::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['atom_apm']).converge(described_recipe)
  end

  it 'installs the lychee-theme' do
    expect(chef_run).to install_atom_apm('lychee-theme')
  end

  it 'installs the correct version of file-icons' do
    expect(chef_run).to install_atom_apm('file-icons').with(
      version: '1.7.13'
    )
  end
end
