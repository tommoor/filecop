require 'optparse'

module Filecop
  class Options
    def self.parse!(args)
      # The options specified on the command line will be collected here
      options = OpenStruct.new
      
      opt_parser = OptionParser.new do |opts|
        # typical switch to print the version.
        opts.on_tail("--version", "Show version") do
          puts ::Version.join('.')
          exit
        end
      end

      opt_parser.parse!(args)
      [options, args]
    end
  end
end