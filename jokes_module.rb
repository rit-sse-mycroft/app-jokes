# Module for crating jokes
module JokeModule
  # The default delay for jokes
  DEFAULT_DELAY = 1.5

  # Creates a knock knock joke message from a joke hash
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

  # Turns a one liner joke hash into a message to be sent to tts
  def one_liner(joke)
    [{
      phrase: joke,
      delay: 0
    }]
  end

  # Turns a normal joke into a joke to be said to tts
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

  # Creates a special joke
  def special(joke)
    joke
  end

  # Sends a message to tts
  def tts(text)
    content = {text: text, targetSpeaker: "speakers"}
    query('tts', 'stream', content)
  end

end
