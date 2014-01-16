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
  end

  def connect
    # Your code here
  end

  def on_data(data)
    parsed = parse_message(data)
    if parsed[:type] == 'APP_MANIFEST_OK' || parsed[:type] == 'APP_MANIFEST_FAIL'
      check_manifest(parsed)
      @verified = true
    end
  end

  def on_end
    # Your code here
  end
end

Mycroft.start(Jokes)
