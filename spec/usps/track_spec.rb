require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "USPS Track" do
  before(:each) do
    setup_usps_responses
  end

  it "should track the package" do
    use_usps_response(:track_defaults)

    usps = new_usps
    track_details = usps.track(:tracking_number => usps_tracking_number)

    events = track_details.events

    events[0].type.should == "DELIVERED"
    events[0].event_time = "8:10 am"
    events[0].event_date = "June 1, 2001"
    events[0].city.should == "WILMINGTON"
    events[0].state.should == "DE"
    events[0].postal_code.should == "19801"

    events[1].type.should == "NOTICE LEFT"
    events[1].event_time = "11:07 am"
    events[1].event_date = "May 30, 2001"
    events[1].city.should == "WILMINGTON"
    events[1].state.should == "DE"
    events[1].postal_code.should == "19801"

    events[2].type.should == "ARRIVAL AT UNIT"
    events[2].event_time = "10:08 am"
    events[2].event_date = "May 30, 2001"
    events[2].city.should == "WILMINGTON"
    events[2].state.should == "DE"
    events[2].postal_code.should == "19850"

    events[3].type.should == "ACCEPTANCE"
    events[3].event_time = "9:55 pm"
    events[3].event_date = "May 29, 2001"
    events[3].city.should == "EDGEWATER"
    events[3].state.should == "NJ"
    events[3].postal_code.should == "07020"
  end
end
