module Filecop
  class Runner
    def initialize(paths)
      @paths = paths
    end

    def run
      # load banned patterns from config file
      patterns = JSON.parse File.read(File.join(File.dirname(__FILE__), '..', 'patterns.json'))
      rules = patterns.map { |o| Rule.new(o) }
      output = []

      @paths.each do |file|
        rules.each do |rule|
          if rule.matches?(file)
            output << {
              file: file,
              rule: rule
            }
            break
          end
        end
      end
      
      output
    end
  end
end