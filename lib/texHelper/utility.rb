module TexHelper
	module Utility
		def relative_src(src=nil,options)
			Pathname.new(src).relative_path_from Pathname.new(Dir.pwd + '/' + options[:destination])			
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