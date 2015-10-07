require 'erb'
require 'pathname'

module TexHelper
  class Generate < Thor
    include TexHelper::Utility

    def initialize(*args)
      super
      @out = ''
    end

    attr_accessor :out

    class_option :destination, aliases: '-d', default: Dir.pwd,
                               type: :string, banner: 'Output_destination', desc: 'Outpust destination.
      Default is the Working Directory.'
    class_option :times, aliases: '-t', default: 1, type: :numeric,
                         banner: 'Number of Snippets', desc:
      'The Number of times the Snippet shuld be created.'
    class_option :inplace, aliases: '-i', default: false, type: :boolean, desc: 'Wraps Snippet into a Document Template so that it can be compiled as is.'
    class_option :force, aliases: '-f', default: false, type: :boolean, desc: 'Overwrites the output File if it already exists.'
    class_option :verbose, aliases: '-v', default: false, type: :boolean, desc: 'Prints the File to Console if true.'
    class_option :no, aliases: '-n', default: false, type: :boolean, desc: 'Makes a Dry run and doesnt save the File. Also Prints File to Console.'

    method_option :options, aliases: '-o', default: '', type: :string, desc: 'LaTex Options for the includegraphics[OPTIONS]'
    method_option :caption, aliases: '-c', default: '', type: :string, desc: 'Image caption.'
    desc 'figure SOURCE', 'create a figure environment from a given image. If SOURCE is a folder all compatible images will be loaded.'
    def figure(source)
      setup options

      source = Dir.pwd + '/' + source
      source = Pathname.new source

      if source.directory?
        source = Dir.glob(source + '*.png')
        source.sort!
        caption_given = options[:caption].nil? ? false : true
        source.each do |file|
          options[:caption] = Pathname.new(file).basename('.*').to_s unless caption_given
          options[:source] = relative_src file, options
          out << parse_template('figure', options)
        end
      else
        options[:source] = relative_src source, options
        out << parse_template('figure', options)
      end

      finish options
    end

    private

    def setup(options)
      out << parse_template('wrapFront') if options[:inplace]
    end

    def finish(options)
      out << parse_template('wrapBack') if options[:inplace]
      puts out if options[:no] || options[:verbose]
      options[:destination] += '/figure.tex' if Pathname.new(options[:destination]).directory?

      flag = options[:force] ? 'w' : 'a'
      File.open(options[:destination], flag) { |file| file.puts out } unless options[:no]
    end

    def template_path(path = '')
      output = File.expand_path('../../../data/templates/', __FILE__)
      File.expand_path(path, output)
    end

    def parse_template(name, options = {})
      erb = ''
      options[:times] ||= 1
      options[:times].times do
        erb << ERB.new(File.open(template_path name + '.tex.erb').read).result(binding)
      end

      erb
    end
  end
end
