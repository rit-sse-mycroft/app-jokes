require 'mycroft'

class Jokes < Mycroft::Client

  attr_accssor :verified

  def initialize
    @key = '/path/to/key'
    @cert = '/path/to/cert'
    @manifest = './jokes.json'
    @verified = false
  end

  def connect
    # Your code here
  end

  def on_data(data)
    # Your code here
  end

  def on_end
    # Your code here
  end
end

Mycroft.start(Jokes)