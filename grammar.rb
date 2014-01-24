require 'srgs'

module WeatherGrammar
  include Srgs::DSL

  extend self

  grammar 'joke' do
    public_rule 'joke' do
      item "Mycroft tell me a joke"
    end
  end
end