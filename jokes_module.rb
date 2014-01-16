module JokeModule

  def knock_knock(joke)
    [['tts', "Knock Knock"], ['delay', joke["setup_delay"] || 2], ['tts', joke["set_up"]], ['delay', joke["punchline_delay"] || 2], ['tts', joke["punchline"]]]
  end

  def one_liner(joke)
    [['tts', joke]]
  end

  def normal(joke)
    [['tts', joke["set_up"]], ['delay', joke["delay"] || 2], ['tts', joke["punchline"]]]
  end

  def special(joke)
    joke
  end

  def tts(text)
    query('tts', 'say',
     '{"text": #{text}", "targetSpeaker": "speakers"}','text2speech')
  end

  def delay(amount)
    sleep(amount)
  end

end
