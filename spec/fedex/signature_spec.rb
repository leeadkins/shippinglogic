require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FedEx Signature" do
  before(:each) do
    setup_fedex_responses
  end
  
  it "should return an image of the signature" do
    use_fedex_response(:signature_defaults)
    
    fedex = new_fedex
    signature = fedex.signature(:tracking_number => fedex_tracking_number)
    signature.image.should_not be_nil
  end
end
