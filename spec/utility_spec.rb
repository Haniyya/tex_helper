require "spec_helper"
require_relative "../lib/texHelper/utility.rb"

RSpec.describe TexHelper::Utility  do

  let(:dummy) {Class.new{include TexHelper::Utility}}

  it '#find_EOD is not -1 if FIle has an end' do
    expect(dummy.new.find_EOD File.expand_path("../../data/templates/wrapBack.tex.erb",__FILE__)).not_to eq -1
  end

  it '#find_EOD finds the correct position' do
    expect(dummy.new.find_EOD File.expand_path("../../data/templates/wrapBack.tex.erb",__FILE__)).to eq 4 
  end

  it '#relative_src shows correct relative source from pwd' do
    src = "../../data/templates/image.png"
    options = {}
    options[:destination] = "destination.tex" 
    expect(dummy.new.relative_src(src,options)).to eq src
  end

  it '#relative_src stays correctly in the wd' do
    src = "image.png"
    options = {}
    options[:destination] = "destination.tex"
    expect(dummy.new.relative_src(src,options)).to eq src
  end
end
