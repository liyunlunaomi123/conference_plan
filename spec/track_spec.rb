# frozen_string_literal: true

require 'spec_helper'

describe 'ConferencePlan::Track' do
  let(:confplan) { ConferencePlan::Plan.new }
	let(:test_3) { fixture_file('test_3.txt') }
  let(:track) { ConferencePlan::Track.new(Time.now) }
  
  before do
  	track.arrange_talks(confplan.get_talks(test_3)[0])
  end
  
  it 'arrange talks to two sessions' do
		talk_list = confplan.get_talks(test_3)
  	track.arrange_talks(talk_list[0])
  	expect(!!track.morning).to eq true
  	expect(!!track.afternoon).to eq true
  end

  it 'check morning plan start with 9AM' do
   expect(track.morning.first.time.strftime('%I:%M%p')).to eq '09:00AM'
  end

  it 'check afternoon plan start with 1PM' do
   expect(track.afternoon.first.time.strftime('%I:%M%p')).to eq '01:00PM'
  end
end
