module Shippinglogic
  class USPS
    # If USPS responds with an error, we try our best to pull the pertinent information out of that
    # response and raise it with this object. Any time USPS says there is a problem an object of this
    # class will be raised.
    #
    # === Tip
    #
    # If you want to see the raw request / respose catch the error object and call the request / response method. Ex:
    #
    #   begin
    #     # my USPS code
    #   rescue Shippinglogic::USPS::Error => e
    #     # do whatever you want here, just do:
    #     # e.request
    #     # e.response
    #     # to get the raw response from USPS
    #   end
    class Error < Shippinglogic::Error
      def initialize(request, response)
        super
        if response.blank?
          add_error("The response from USPS was blank.")
        elsif !response.is_a?(Hash)
          add_error("The response from USPS was malformed and was not in a valid XML format.")
        elsif response[:error]
          error = response[:error]
          add_error(error[:description], :code => error[:number], :source => error[:source], :help_file => error[:help_file], :help_context => error[:help_context])
        else
          add_error(
            "There was a problem with your USPS request, and we couldn't locate a specific error message. This means your response " +
            "was in an unexpected format. You might try glancing at the raw response by using the 'response' method on this error object."
          )
        end
      end
    end
  end
end