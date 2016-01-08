module Filecop
  class CLI

    def run(args = ARGV)
      @options, @paths = Options.parse!(args)
      @paths = Dir.entries(".") if @paths.length==0
      runner = Runner.new(@paths)

      if @options.json
        files = runner.run
        puts JSON.generate files.map { |p| { file: p[:file], message: p[:rule].message } } 
      else
        puts "Checking #{@paths.length} files\n"
        files = runner.run
        
        if files.length>0
          puts "\nIssues:\n\n"
        end
        puts files.map { |p| "#{p[:file]}: #{p[:rule].message}" } 
        puts "\n"
        puts "#{@paths.length} files checked, #{files.length} potential problems"
      end

      return files.length>0 ? 1 : 0
    rescue StandardError, SyntaxError => e
      $stderr.puts e.message
      $stderr.puts e.backtrace
      return 1
    end
  end
end