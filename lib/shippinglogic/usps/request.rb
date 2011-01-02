require "builder"

module Shippinglogic
  class USPS
    # Methods relating to building and sending a request to USPS's web services.
    module Request
      private
        # Convenience method for sending requests to USPS
        def request(body)
          real_class.post(base.url, :body => {:API => real_class.api, :XML => body})
        end

        def builder
          Builder::XmlMarkup.new(:indent => 2)
        end
    end
  end
end