require "shippinglogic/usps/service"
require "shippinglogic/usps/track"

module Shippinglogic
  class USPS

    def self.options
      @options ||= {
        :test => !!(defined?(Rails) && !Rails.env.production?),
        :production_url => "http://production.shippingapis.com/ShippingAPI.dll",
        :secure_production_url => "https://secure.shippingapis.com/ShippingAPI.dll",
        :test_url => "http://testing.shippingapis.com/ShippingAPITest.dll"
      }
    end

    attr_accessor :username, :password, :options

    def initialize(username, password, options = {})
      self.username = username
      self.password = password
      self.options = self.class.options.merge(options)
    end

    # A convenience method for accessing the endpoint URL for the FedEx API.
    def url
      return options[:test_url] if options[:test]
      return options[:production_url] if options[:secure] == false
      return options[:secure_production_url] # default to secure url
    end

    def track(attributes = {})
      @track ||= Track.new(self, attributes)
    end
  end
end