require "spec_helper"

RSpec.describe Utility, '#find_EOD' do
	describe '#find_EOD' do

		expect(find_EOD "data/templates/wrabBack.tex.erb").not_to eq -1
	end

end