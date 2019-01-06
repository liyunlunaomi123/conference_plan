# frozen_string_literal: true

require 'conference_plan/version'
require 'conference_plan/talk'
require 'conference_plan/track'

module ConferencePlan
  class Plan
    attr_reader :total_time, :tracks

    def get_talks(talk_list)
      talks = talk_list.split("\n").map do |talk|
        Talk.new(talk)
      end
      # sort talks by talk_length
      @total_time =
        talks.map(&:talk_length).inject do |sum, talk_length|
          sum + talk_length
        end

      talks.sort! { |talk1, talk2| talk2.talk_length <=> talk1.talk_length }

      @tracks = []
      separate_talks_by_tracks = []

      # calculate number of tracks that needed
      (@total_time / (6 * 60)).times do
        @tracks << Track.new(Time.now)
        separate_talks_by_tracks << []
      end
      # separate talks into different tracks
      talks.each_with_index do |talk, i|
        separate_talks_by_tracks[i % separate_talks_by_tracks.length] << talk
      end

      separate_talks_by_tracks.each_with_index do |talks_per_track, i|
        @tracks[i].arrange_talks(talks_per_track)
      end
    end

    def formatting_track
      @tracks.each_with_index.map do |track, index|
        total_track = track.morning + [track.lunch] + track.afternoon + [track.networking_event]
        "Track #{index + 1}:\n" +
          total_track.map(&:formatting_talk).join("\n")
      end.join("\n\n")
    end
  end
end
