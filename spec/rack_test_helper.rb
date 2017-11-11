require 'rack/test'

ENV['RACK_ENV'] = 'test'

require './sinatra_app' 

module RackMixin
    include Rack::Test::Methods
    def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RackMixin }
