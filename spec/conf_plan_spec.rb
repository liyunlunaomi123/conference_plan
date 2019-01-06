# frozen_string_literal: true

require 'spec_helper'

describe 'ConferencePlan::Plan' do
  let(:confplan) { ConferencePlan::Plan.new }

  describe 'test file test_1' do
    let(:test_1) { fixture_file('test_1.txt') }
    let(:result_1) do
      <<-MSG.gsub(/^\s+\|/, '').chomp
        |Track 1:
        |09:00AM Writing Fast Tests Against Enterprise Rails 60min
        |10:00AM Ruby on Rails Legacy App Maintenance 60min
        |11:00AM Communicating Over Distance 60min
        |12:00PM Lunch
        |01:00PM Common Ruby Errors 45min
        |01:45PM Ruby Errors from Mismatched Gem Versions 45min
        |02:30PM Pair Programming vs Noise 45min
        |03:15PM Woah 30min
        |03:45PM Programming in the Boondocks of Seattle 30min
        |04:15PM Lua for the Masses 30min
        |04:45PM Rails for Python Developers lightning
        |04:50PM Networking Event
        |
        |Track 2:
        |09:00AM Rails Magic 60min
        |10:00AM Ruby on Rails: Why We Should Move On 60min
        |11:00AM Sit Down and Write 30min
        |11:30AM User Interface CSS in Rails Apps 30min
        |12:00PM Lunch
        |01:00PM Clojure Ate Scala (on my project) 45min
        |01:45PM Accounting-Driven Development 45min
        |02:30PM Overdoing it in Python 45min
        |03:15PM A World Without HackerNews 30min
        |03:45PM Ruby vs. Clojure for Back-End Development 30min
        |04:15PM Networking Event
      MSG
    end
    
    let(:test_2) { fixture_file('test_2.txt') }
    let(:result_2) do
      <<-MSG.gsub(/^\s+\|/, '').chomp
        |Track 1:
        |09:00AM b 60min
        |10:00AM b 60min
        |11:00AM d 60min
        |12:00PM Lunch
        |01:00PM i 45min
        |01:45PM f 45min
        |02:30PM e 40min
        |03:10PM l 30min
        |03:40PM p 30min
        |04:10PM r 30min
        |04:40PM s lightning
        |04:45PM Networking Event
        |
        |Track 2:
        |09:00AM b 60min
        |10:00AM a 60min
        |11:00AM q 30min
        |11:30AM p 30min
        |12:00PM Lunch
        |01:00PM h 45min
        |01:45PM g 45min
        |02:30PM j 45min
        |03:15PM c 40min
        |03:55PM l 30min
        |04:25PM Networking Event
        |
        |Track 3:
        |09:00AM d 60min
        |10:00AM a 60min
        |11:00AM r 30min
        |11:30AM o 30min
        |12:00PM Lunch
        |01:00PM k 45min
        |01:45PM i 45min
        |02:30PM m 40min
        |03:10PM n 30min
        |03:40PM q 30min
        |04:10PM Networking Event
      MSG
    end


    it 'test text test_1' do
      confplan.get_talks(test_1)
      expect(confplan.formatting_track).to eq result_1
    end

    it 'test text test_2' do
      confplan.get_talks(test_2)
      expect(confplan.formatting_track).to eq result_2
    end
  end
end
