require 'sinatra'
require 'digest/bubblebabble'
require 'dalli'

configure { set :server, :puma }

get '/' do
    'Hello world!'
end

get '/bubblebabble/:message' do
    options = { namespace: ENV['MEMCACHE_NAMESPACE'] }
    cache = Dalli::Client.new(ENV['MEMCACHE_SERVERS'], options)
    result = cache.get(params[:message]) || Digest::SHA256.bubblebabble(params[:message])
    cache.add(params[:message], result)
    result
end
