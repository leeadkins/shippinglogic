require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FedEx Service" do
  before(:each) do
    setup_fedex_responses
  end

  it "should not hit fedex until needed" do
    # If fedex was hit we would get an exception before the response is blank
    use_fedex_response(:blank)
    lambda { new_fedex.track(:tracking_number => fedex_tracking_number) }.should_not raise_error
  end
  
  it "should hit fedex when needed" do
    use_fedex_response(:blank)
    lambda { new_fedex.track(:tracking_number => fedex_tracking_number).size }.should raise_error(Shippinglogic::FedEx::Error)
  end
  
  it "should delegate the class method to the target" do
    use_fedex_response(:track_defaults)
    new_fedex.track(:tracking_number => fedex_tracking_number).class.should == Shippinglogic::FedEx::Track::Details
  end
end
