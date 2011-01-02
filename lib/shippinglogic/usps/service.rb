require "shippinglogic/usps/request"
require "shippinglogic/usps/response"

module Shippinglogic
  class USPS
    class Service < Shippinglogic::Service
      format :xml # set HTTParty response format
      include Request
      include Response
    end
  end
end