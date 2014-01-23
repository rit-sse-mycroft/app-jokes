module JokeModule
  DEFAULT_DELAY = 2

  def knock_knock(joke)
    [{
      phrase: 'Knock Knock',
      delay: joke['setup_delay'] || DEFAULT_DELAY
    },
    {
      phrase: joke['set_up'],
      delay: joke['punchline_delay'] || DEFAULT_DELAY
    },
    {
      phrase: joke['punchline'],
      delay: 0
    }]
  end

  def one_liner(joke)
    [{
      phrase: joke,
      delay: 0
    }]
  end

  def normal(joke)
    [{
      phrase: joke["set_up"],
      delay: joke['delay'] || DEFAULT_DELAY
    },
    {
      phrase: joke['punchline'],
      delay: 0
    }]
  end

  def special(joke)
    joke
  end

  def tts(text)
    content = {text: text, targetSpeaker: "speakers"}
    query('tts', 'stream', content)
  end

end
