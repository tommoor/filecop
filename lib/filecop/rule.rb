module Filecop
  class Rule
    def initialize(options)
      @part = options['part']
      @type = options['type']
      @pattern = options['pattern']
      @caption = options['caption']
      @description = options['description']
    end
  
    def matches?(file)
      parts = {
        path: file,
        filename: Pathname.new(file).basename,
        extension: File.extname(file).delete('.')
      }
      to_check = parts[@part.to_sym].to_s
    
      if @type == 'regex'
        reg = Regexp.new(@pattern, true)
        reg.match(to_check)
      else
        to_check == @pattern
      end
    end
  
    def message
      output = "#{@caption}."
      output += " #{@description}" if @description
      output
    end
  end
end