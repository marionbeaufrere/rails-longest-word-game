require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def score
    if included?(params[:word].upcase, params[:grid])
      if english_word?(params[:word])
        @message = "well done"
      else
        @message = "not an english word"
      end
    else
        @message = "not in the grid"
    end
  end
end

