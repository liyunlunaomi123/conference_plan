# frozen_string_literal: true

module ConferencePlan
  class Talk
    attr_reader :title
    attr_accessor :talk_length, :time

    def initialize(talk)
      # split talk into talk_length and title
      split_string = talk.split(' ')
      @talk_length = split_string.last
      @title = split_string.take(split_string.length - 1).join(' ')
      raise 'Cannot have numbers in title.' if title =~ /\d+/

      @talk_length = if talk_length =~ /lightning/
                       5
                     else
                       talk_length.gsub('min', '').to_i
                     end
    end

    def formatting_talk
      formated_talk_length =
        if ['Lunch', 'Networking Event'].include?(title)
          ''
        elsif talk_length == 5
          ' lightning'
        else
          " #{talk_length}min"
        end
      time.strftime('%I:%M%p') + ' ' + title + formated_talk_length
    end
  end
end
