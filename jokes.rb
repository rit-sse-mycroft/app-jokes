require 'jokes_module'
require 'mycroft'
require 'yaml'

class Jokes < Mycroft::Client

  attr_accessor :verified

  def initialize
    @key = ''
    @cert = ''
    @manifest = './app.json'
    @verified = false
    @jokes = YAML.load_file('./jokes.yml').shuffle
    @jokes_used = Array.new
    @cur_joke = nil
  end

  def connect
    # Your code here
  end

  def on_data(data)
    parsed = parse_message(data)
    if parsed[:type] == 'APP_MANIFEST_OK' || parsed[:type] == 'APP_MANIFEST_FAIL'
      check_manifest(parsed)
      @verified = true
    elsif parsed[:type] == 'MSG_BROADCAST'
      if (parsed[:data]["content"]["text"].index("joke") != nil)
        set_current_joke
      end
      #do stuff here
    elsif parsed[:type] == 'APP_DEPENDENCY'
      #do other stuff here
    end
  end

  def on_end
    # Your code here
  end

  def set_current_joke
    if (@cur_joke == nil)
      c_joke = @jokes.pop
      @jokes_used.push(c_joke)
      @cur_joke = JokeModule.send(c_joke['type'].to_sym, c_joke['joke'])
    end
  end

  def tell_joke
    until(@cur_joke.empty?)
      action_block = @cur_joke.shift
      send(action_block[0].to_sym, action_block[1])
    end
  end
end

Mycroft.start(Jokes)
