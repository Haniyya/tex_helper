require_relative 'generate.rb'
require 'pathname'
require 'ruby-progressbar'

module TexHelper
  class Application < Thor
    include Thor::Actions
    include TexHelper::Utility

    desc 'version', 'shows the current version'
    def version
      puts 'texHelper 0.0.1'
    end

    # TODO
    desc 'include PARTIAL MASTER', 'Includes one or many Partial tex File at the End of a Master file. NOT WORKING YET.'
    def include(partial, _master)
      puts find_EOD partial
    end

    desc 'cleanCompile FILE', 'cc for short.Compiles a Tex-File cleanly by Extracting the auxilary Files into a different seperate directory.'
    def cleanCompile(file)
      pb = ProgressBar.create
      file = Pathname.new(file)

      Dir.chdir(file.parent)

      aux_dir = file.basename('.tex').to_s + '_aux'
      puts aux_dir
      10.times { pb.increment }

      system "mkdir -p #{aux_dir}"
      10.times { pb.increment }

      puts file.basename
      2.times do
        system "pdflatex -interaction=batchmode -output-directory=#{aux_dir} #{file.basename}"
        40.times { pb.increment }
      end

      system "mv #{aux_dir}/#{file.basename('.tex').to_s + '.pdf'} #{Dir.pwd}"
    end

    register(Generate, 'create', 'create <snippet>', 'Create a tex-snippet.')
    map cc: :cleanCompile

    private
  end
end
