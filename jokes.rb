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
      update_dependencies(parsed[:data])
      puts "Current status of dependencies"
      puts @dependencies
      if not parsed[:data]['stt'].nil?
        if parsed[:data]['stt']['stt1'] == 'up' and not @sent_grammar
          up
          data = {grammar: { name: 'joke', xml: File.read('./grammar.xml')}}
          query('stt', 'load_grammar', data)
          @sent_grammar = true
        elsif parsed[:data]['stt']['stt1'] == 'down' and @sent_grammar
          @sent_grammar = false
          down
        end
      end
      # Dependencies: Speech to Text, Text to Speech
      # Look for Speech
      update_dependencies(parsed[:data])
      puts "Current status of dependencies"
      puts @dependencies
    end
  end

  def on_end
    broadcast({unloadGrammar: 'joke'})
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

  def update_dependencies(deps)
    deps.each do |capability, instance|
      instance.each do |appId, status|
        if @dependencies.has_key?(capability)
          @dependencies[capability][appId] = status
        else
          @dependencies[capability] = {}
          @dependencies[capability][appId] = status
        end
      end
    end    
  end
end


Mycroft.start(Jokes)
