require './jokes_module'
require 'mycroft'
require 'yaml'

class Jokes < Mycroft::Client
  include JokeModule
  attr_accessor :verified

  def initialize(host, port)
    @key = ''
    @cert = ''
    @manifest = './app.json'
    @verified = false
    @jokes = YAML.load_file('./jokes.yml').shuffle
    @jokes_used = Array.new
    @dependencies = {}
    @state = "APP_DOWN"
    @sent_grammar = false
    super
  end

  def connect
    # Your code here
  end

  def on_data(parsed)
    if parsed[:type] == 'MSG_BROADCAST'
      if parsed[:data]["content"]["text"].include? 'joke'
        tell_joke
      end
    elsif parsed[:type] == 'APP_DEPENDENCY'
      # Dependencies: Speech to Text, Text to Speech
      # Look for Speech
      update_dependencies(parsed[:data])
      puts "Current status of dependencies"
      puts @dependencies
      if not @dependencies['stt'].nil?
        if @dependencies['stt']['stt1'] == 'up' and not @sent_grammar
          up
          data = {grammar: { name: 'joke', xml: File.read('./grammar.xml')}}
          query('stt', 'load_grammar', data)
          @sent_grammar = true
        elsif @dependencies['stt']['stt1'] == 'down' and @sent_grammar
          @sent_grammar = false
          down
        end
      end
    elsif parsed[:type] == 'MSG_GENERAL_FAILURE'
      puts parsed[:data]['message']
    end
  end

  def on_end
    query('stt', 'unload_grammar', {grammar: 'joke'})
  end

  def tell_joke
    if @jokes.empty?
      @jokes = @jokes_used.shuffle
      @jokes_used = Array.new
    end
    joke = @jokes.pop
    @jokes_used << joke
    cur_joke = send(joke['type'].to_sym, joke['joke'])
    tts(cur_joke)
  end
end


Mycroft.start(Jokes)
