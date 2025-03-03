require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @array = Array.new(10) { ('A'..'Z').to_a.sample }
    @letters = @array.join(' ')
  end

  def score
    if included?(params[:word].upcase, params[:letters])
      if english_word?(params[:word])
        @sentence = "Congratulations! #{params[:word]} is a valid English word!"
      else
        @sentence = "Sorry but #{params[:word]} does not seem to be a valid word"
      end
    else
      @sentence = "Sorry but #{params[:word]} can't be built out of #{params[:letters]}"
    end
  end

  private

  def english_word?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    user = URI.open(url).read
    json = JSON.parse(user)
    json['found']
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
