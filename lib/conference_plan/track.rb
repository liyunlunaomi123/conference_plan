# frozen_string_literal: true

module ConferencePlan
  class Track
    attr_reader :date
    attr_accessor :morning, :lunch, :afternoon, :networking_event
    def initialize(date)
      @date = date
    end

    def arrange_talks(talks_per_track)
      @total_time =
        talks_per_track.map(&:talk_length).inject do |sum, talk_length|
          sum + talk_length
        end
      raise 'Do not have enough talks for one day plan' if @total_time < 6 * 60

      get_morning_plan(talks_per_track)
      get_lunch_plan
      get_afternoon_plan(talks_per_track)
      get_networking_event_plan
    end


    def get_morning_plan(talks_per_track)
      # get morning plan from 9am      
      morning_talks = get_morning_talks(talks_per_track, 3 * 60)
      morning_talks.first.time = Time.new(date.year, date.month, date.day, 9, 0)
      @morning = 
        morning_talks.each_with_index.inject([]) do |arr, (talk, i)|
          unless i == 0
            pre_talk = morning_talks[i - 1]
            talk.time = pre_talk.time + pre_talk.talk_length * 60
          end
          arr << talk
        end
    end
    
    def get_lunch_plan
      @lunch = Talk.new('Lunch 60min')
      lunch.time = Time.new(date.year, date.month, date.day, 12, 0)
    end
    

    def get_afternoon_plan(talks_per_track)
      # get afternoon plan from 1pm  
      afternoon_talks = talks_per_track.reject { |talk| morning.include?(talk) }
        afternoon_talks.first.time = Time.new(date.year, date.month, date.day, 13, 0)
        @afternoon = 
          afternoon_talks.each_with_index.inject([]) do |arr, (talk, i)|
          unless i == 0
            pre_talk = afternoon_talks[i - 1]
            talk.time = pre_talk.time + pre_talk.talk_length * 60
          end
          arr << talk
        end
    end
    
    def get_networking_event_plan
      @networking_event = Talk.new('Networking Event 60min')
      networking_event.time =
        afternoon.last.time + afternoon.last.talk_length * 60
    end

    def get_morning_talks(talks_per_track, morning_session_time)
      (1..talks_per_track.size).each do |combination_size|
        talks_per_track.combination(combination_size).each do |combination|
          if combination.map(&:talk_length)
              .inject { |sum, talk_length| sum + talk_length } == morning_session_time
            return combination
          end
        end
      end
      raise 'Can not fill in morning session'
    end
  end
end
