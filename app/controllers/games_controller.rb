class GamesController < ApplicationController
  def new
    @letters = generate_random_letters(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]

    if valid_word?(@word, @letters)
      if english_word?(@word)
        # Le mot est valide
        @result = "valid"
      else
        # Le mot est invalide
        @result = "valid_not_english"
      end
    else
      # Le mot ne peut pas être créé à partir des lettres d'origine
      @result = "invalid"
    end
  end

  private

  def generate_random_letters(count)
    alphabet = ('A'..'Z').to_a
    letters = []
    count.times { letters << alphabet.sample }
    letters
  end

  def valid_word?(word, letters)
    # A FAIRE :vérifier si le mot peut être créé à partir des lettres d'origine
  end

  def english_word?(word)
    response = HTTParty.get("https://wagon-dictionary.herokuapp.com/#{word}")
    result = JSON.parse(response.body)
    result["found"]
  end
end
