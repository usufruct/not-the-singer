require './spec/spec_helper'
require './spec/rack_test_helper'
require 'digest/bubblebabble'

RSpec.describe 'does it work' do
    it 'does' do
        expect(true).to be(true)
    end
end

RSpec.describe 'the sinatra application' do
    it 'should say hello at the homepage' do
        get '/'
        expect(last_response.body).to eq('Hello world!')
    end

    it 'should babble when it needs to' do
        get '/bubblebabble/fubar'
        expect(last_response.body).to eq(Digest::SHA256.bubblebabble 'fubar')
    end

    it 'will save babble results to memcache' do
        options = { namespace: ENV['MEMCACHE_NAMESPACE'] }
        cache = Dalli::Client.new(ENV['MEMCACHE_SERVERS'], options)
        get '/bubblebabble/foo'
        expect(cache.get('foo')).to eq(Digest::SHA256.bubblebabble('foo'))
    end
end
