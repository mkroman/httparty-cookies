# encoding: utf-8

require 'httparty'
require 'http-cookie'

module HTTParty
  module Cookies
    def self.included base
      # Include HTTParty first
      base.send :include, HTTParty
      base.extend ClassMethods
      base.send :mattr_inheritable, :cookie_jar

      # Create a new cookie jar
      base.instance_variable_set :@cookie_jar, HTTP::CookieJar.new
    end

    module ClassMethods
      def perform_request http_method, path, options, &block
        options = default_options.dup.merge options

        request = Request.new http_method, path, options
        process_cookies request
        response = request.perform(&block)

        # Read cookies from the headers.
        c = response.headers.get_fields('set-cookie')
        c.each do |value|
          uri = response.uri || response.request.uri

          @cookie_jar.parse value, uri
        end unless c.nil?

        response
      end

      # Add cookies from the cookie jar.
      def process_cookies request
        cookie_header = HTTP::Cookie.cookie_value @cookie_jar.cookies request.uri

        unless cookie_header.empty?
          request.options[:headers] ||= {}
          request.options[:headers]["cookie"] = cookie_header
        end
      end
    end
  end
end
