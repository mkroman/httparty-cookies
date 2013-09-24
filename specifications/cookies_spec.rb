require 'spec_helper'

describe HTTParty::Cookies do
  before :each do
    @klass = Class.new
    @klass.instance_eval { include HTTParty::Cookies }
  end

  context "when included" do
    it "should include HTTParty" do
      @klass.included_modules.should include HTTParty
    end

    it "should create a cookie jar" do
      @klass.cookie_jar.should be_kind_of HTTP::CookieJar
    end
  end

  context "when requesting" do
    let(:uri) { URI "http://uplink.io/" }

    before :each do
      # @klass.follow_redirects false
      @klass.cookie_jar.parse "ABC=DEF; Path=/", uri
    end
  end
end
