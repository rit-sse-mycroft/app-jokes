module JokeModule 
  extend self

  def knock_knock(joke)
    [['tts', "Knock Knock"], ['delay', joke["setup_delay"] or 2], ['tts', joke["set_up"]], ['delay', joke["punchline_delay"] or 2], ['tts', joke["punchline"]]]
  end

  def one_liner(joke)
    [['tts', joke]]
  end

  def normal(joke)
    [['tts', joke["set_up"]], ['delay', joke["delay"] or 2], ['tts', joke["punchline"]]]
  end

  def special(joke)
    joke
  end

end
