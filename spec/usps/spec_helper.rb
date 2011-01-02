require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

Shippinglogic::USPS.options[:test] = true
Spec::Runner.configure do |config|
  config.before(:each) do
    def setup_usps_responses
      HTTParty::Request.response_directory = File.dirname(__FILE__) + "/responses"
      FakeWeb.clean_registry

      if File.exists?("#{SPEC_ROOT}/usps/responses/_new.xml")
        raise "You have a new response in your response folder, you need to rename this before we can continue testing."
      end
    end

    def new_usps
      Shippinglogic::USPS.new(*usps_credentials.values_at("username", "password"))
    end

    def usps_credentials
      return @usps_credentials if defined?(@usps_credentials)

      usps_credentials_path = "#{SPEC_ROOT}/config/usps_credentials.yml"

      unless File.exists?(usps_credentials_path)
        raise "You need to add your own USPS test credentials in spec/config/usps_credentials.yml. See spec/config/usps_credentials.example.yml for an example."
      end

      @usps_credentials = YAML.load(File.read(usps_credentials_path))
    end

    def usps_tracking_number
      "077973360403984"
    end

    def use_usps_response(key, options = {})
      path = "#{SPEC_ROOT}/usps/responses/#{key}.xml"
      if File.exists?(path)
        options[:content_type] ||= "text/xml"
        options[:body] ||= File.read(path)
        url = Shippinglogic::USPS.options[:test_url]
        FakeWeb.register_uri(:post, url, options)
      end
    end
  end
end