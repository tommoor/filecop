require 'spec_helper'

describe Filecop do
  it 'has a version number' do
    expect(Filecop::VERSION).not_to be nil
  end

  describe Filecop::CLI, :isolated_environment do
    subject(:cli) { described_class.new }
    
    before(:each) do
      $stdout = StringIO.new
      $stderr = StringIO.new
    end

    after(:each) do
      $stdout = STDOUT
      $stderr = STDERR
    end
    
    context "with no files provided" do
      it 'returns 1' do
        expect(cli.run).to eq(1)
      end
    end
    
    context "with sensitive files provided" do
      it 'returns text formatted result' do
        expect(cli.run(['id_rsa'])).to eq(1)
        expect($stdout.string).to eq(
"Checking 1 files

Issues:

id_rsa: Private SSH key.

1 files checked, 1 potential problems
")
      end
    end
    
    context "when --json argument is passed" do
      it 'returns json formatted result' do
        expect(cli.run(['--json', 'id_rsa'])).to eq(1)
        expect($stdout.string).to eq(JSON.generate([{file: 'id_rsa', message: "Private SSH key."}]) + "\n")
      end
    end
  end
end
