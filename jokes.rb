require './jokes_module'
require 'mycroft'
require 'yaml'

class Jokes < Mycroft::Client
  include JokeModule
  attr_accessor :verified

  def initialize
    @key = ''
    @cert = ''
    @manifest = './app.json'
    @verified = false
    @jokes = YAML.load_file('./jokes.yml').shuffle
    @jokes_used = Array.new
    @cur_joke = []
  end

  def connect
    # Your code here
  end

  def on_data(data)
    puts data
    parsed = parse_message(data)
    if parsed[:type] == 'APP_MANIFEST_OK' || parsed[:type] == 'APP_MANIFEST_FAIL'
      check_manifest(parsed)
      @verified = true
    elsif parsed[:type] == 'MSG_BROADCAST'
      if parsed[:data]["content"]["text"].include? 'joke'
        set_current_joke
        tell_joke
      end
    elsif parsed[:type] == 'MSG_QUERY_SUCCESS'
      tell_joke
    elsif parsed[:type] == 'APP_DEPENDENCY'
      #do other stuff here
    end
  end

  def on_end
    # Your code here
  end

  def set_current_joke
    if @cur_joke.empty?
      c_joke = @jokes.pop
      @jokes_used.push(c_joke)
      # call the method named the type of joke that c_joke is (meta-programming, ahhhh yeah)
      @cur_joke = send(c_joke['type'].to_sym, c_joke['joke'])
    end
    if @jokes.empty?
      @jokes = @jokes_used
      @jokes.shuffle!
      @jokes_used = []
    end
  end

  def tell_joke
    unless @cur_joke.empty?
      action_block = @cur_joke.shift
      send(action_block[0].to_sym, action_block[1])
    end
  end
end

Mycroft.start(Jokes)
