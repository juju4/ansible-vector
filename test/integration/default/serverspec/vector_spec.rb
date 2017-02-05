require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

describe file('/var/_vector/vector/dist') do
  it { should be_directory }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
end
describe file('/var/_vector/vector/dist/index.html') do
  it { should be_file }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable.by('others') }
end

describe command('curl -Ss http://localhost/vector/') do
  its(:stdout) { should match /<title>Vector<\/title>/ }
  its(:exit_status) { should eq 0 }
end

