require "json"
require "pathname"

require "filecop/version"
require "filecop/options"
require "filecop/rule"

module Filecop
  class CLI

    def run(args = ARGV)
      @options, @paths = Options.parse!(args)

      # load banned patterns from config file
      patterns = JSON.parse File.read(File.join(File.dirname(__FILE__), 'patterns.json'))
      rules = patterns.map { |o| Rule.new(o) }
      output = []

      @paths.each do |file|
        rules.each do |rule|
          if rule.matches?(file)
            output << {
              file: file,
              message: rule.message
            }
            break
          end
        end
      end
      
      puts output
    rescue StandardError, SyntaxError => e
      $stderr.puts e.message
      $stderr.puts e.backtrace
      return 1
    end
  end
end