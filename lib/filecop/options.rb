require 'optparse'

module Filecop
  class Options
    def self.parse!(args)
      # The options specified on the command line will be collected here
      options = OpenStruct.new
      options.json = false

      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: filecop [options] [file1, file2, ...]'

        opts.on("-j", "--json", "Output as JSON") do |v|
          options.json = true
        end

        opts.on_tail('--version', 'Show version') do
          puts Filecop::VERSION
          exit
        end
      end

      opt_parser.parse!(args)
      [options, args]
    end
  end
end