require 'spec_helper'

describe Backbone do

	it "should display a home page" do
		get '/'
		last_response.should be_ok
	end

	it "should display a blog page at /blog" do
		get '/blog'
		last_response.should be_ok
	end
end