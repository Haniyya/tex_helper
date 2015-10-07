module TexHelper
  ## Utility Module to provide file interaction Methods.
  module Utility
    def relative_src(src, options)
      src = Pathname.new(Dir.pwd + src)
      destination = Pathname.new(Dir.pwd + options[:destination])
      path = src.relative_path_from(destination).to_s
      path.slice!(0, 3)
      path
    end

    def find_EOD(file)
      lines = File.readlines file

      lines.each_with_index do |l, i|
        return i + 1 if l.include? '\\end{document}'
      end

      -1
    end
  end
end
