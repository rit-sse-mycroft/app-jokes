module JokeModule 
  extend self

  def knock_knock(joke)
    [[:tts, "Knock Knock"], [:stt, "Who's there"], [:tts, joke["set_up"]], [:stt, "#{joke["set_up"]} who"], [:tts, joke["punchline"]]]
  end

  def one_liner(joke)
    [[:tts, joke]]
  end

  def normal(joke)
    [[:tts, joke["set_up"]], [:delay, joke["delay"] or 2], [:tts, joke["punchline"]]]
  end

end
