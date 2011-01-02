require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "USPS" do
  it "should return the default options" do
    spec_helper_options = Shippinglogic::USPS.options
    Shippinglogic::USPS.instance_variable_set("@options", nil)

    Shippinglogic::USPS.options.should == {
      :test => false,
      :production_url => "http://production.shippingapis.com/ShippingAPI.dll",
      :secure_production_url => "https://secure.shippingapis.com/ShippingAPI.dll",
      :test_url => "http://testing.shippingapis.com/ShippingAPITest.dll"
    }

    Shippinglogic::USPS.instance_variable_set("@options", spec_helper_options)
  end
end
