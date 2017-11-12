require 'sinatra'
require 'digest/bubblebabble'
require 'dalli'

configure { set :server, :puma }

get '/' do
    'Hello world!'
end

get '/bubblebabble/:message' do
    Digest::SHA256.bubblebabble params[:message]
end
