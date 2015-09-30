module TexHelper
  module Utility
    def relative_src(src,options)
      src = Pathname.new(Dir.pwd + src)
      destination = Pathname.new(Dir.pwd + options[:destination])
      path =  src.relative_path_from(destination).to_s
      path.slice!(0,3)
      return path
    end

    def find_EOD(file)
      lines = File.readlines file

      lines.each_with_index do |l,i|
        if l.include? '\\end{document}'
          return i + 1 
        end
      end

      return -1 
    end
  end	
end
