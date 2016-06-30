RSpec.describe 'atom_test::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['atom_apm']).converge(described_recipe)
  end

  before(:example) do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with(
      'atom'
    )
  end

  it 'installs the lychee-theme' do
    expect(chef_run).to install_atom_apm('lychee-theme')
  end

  it 'installs the correct version of file-icons' do
    expect(chef_run).to install_atom_apm('file-icons').with(
      version: '1.7.13'
    )

    expect(chef_run).to run_execute('apm install file-icons@1.7.13 --no-color --production')
  end

  it 'removes git-plus' do
    expect(chef_run).to remove_atom_apm('git-plus')

    expect(chef_run).to run_execute('apm uninstall git-plus --no-color')
  end
end
