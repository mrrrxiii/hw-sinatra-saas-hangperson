class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  def initialize(word)
    @word = word
    @guesses=''
    @wrong_guesses=''
  end

  def guess(guess)
    if guess=='' || (guess =~/^[a-zA-Z]*$/)==nil||guess==nil
      raise ArgumentError
    end
    if @word.downcase.include?(guess.downcase)
      if @guesses==''||!@guesses.downcase.include?(guess.downcase)
          @guesses+=guess
          return true
      end
     
    else
      if @wrong_guesses==''||!@wrong_guesses.downcase.include?(guess.downcase)
        @wrong_guesses+=guess
        return true
      end
      
    end
    return false
  end
  
  def word_with_guesses
    result=''
    word.each_char do |x|
      if @guesses.downcase.include?(x.downcase)
        result+=x
      else
        result+='-'
      end
    end
    return result
  end
  
  def check_win_or_lose
    if @wrong_guesses.length>=7
      return :lose
    end
    if word_with_guesses==@word
      return :win
    end
    if @wrong_guesses.length<7
      return :play
    end
  end
  
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
