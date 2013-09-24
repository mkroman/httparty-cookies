# encoding: utf-8

require 'httparty'
require 'cookiejar'

module HTTParty
  module Cookies
    def self.included base
      base.send :include, HTTParty
      base.extend ClassMethods
      base.send :mattr_inheritable, :cookie_jar
      base.instance_variable_set :@cookie_jar, CookieJar::Jar.new
    end

    module ClassMethods
    private
      def perform_request http_method, path, options, &block
        options = default_options.dup.merge options

        request = Request.new http_method, path, options
        process_cookies request
        response = request.perform(&block)

        # Read cookies from the headers.
        response.headers.get_fields('Set-Cookie').each do |cookie|
          uri = response.uri || response.request.uri

          @cookie_jar.set_cookie uri, cookie
        end

        response
      end

      # Add cookies from the cookie jar.
      def process_cookies request
        cookie_header = @cookie_jar.get_cookie_header request.uri

        unless cookie_header.empty?
          request.options[:headers] ||= {}
          request.options[:headers]["cookies"] = cookie_header
        end
      end
    end
  end
end
