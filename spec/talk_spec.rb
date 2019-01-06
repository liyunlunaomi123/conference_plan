# frozen_string_literal: true

require 'spec_helper'

describe 'ConferencePlan::Talk' do
  let(:class_talk) { ConferencePlan::Talk }
  let(:talk_1) do
    class_talk.new('Ruby Errors from Mismatched Gem Versions 45min')
  end
  let(:talk_2) { class_talk.new('Writing Fast Tests lightning') }

  it 'check title' do
    expect(talk_1.title).to eq \
      'Ruby Errors from Mismatched Gem Versions'
  end

  it 'check talk_length' do
    expect(talk_1.talk_length).to eq 45
  end

  it 'can separate lightning with title' do
    expect(talk_2.talk_length).to eq 5
  end

  it 'do not accept numbers in title' do
    expect do
      class_talk.new('Writing Fast Tests 1233 lightning')
    end.to raise_error(StandardError)
  end
end
