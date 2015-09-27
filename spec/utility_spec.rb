require "spec_helper"
require_relative "../lib/texHelper/utility.rb"

RSpec.describe "User-module" do

  let(:dummy) {Class.new{include TexHelper::Utility}}

  it '#find_EOD' do
    expect(dummy.new.find_EOD "../data/templates/wrapBack.tex.erb").not_to eq -1
  end

end
