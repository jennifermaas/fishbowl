require 'spec_helper'

describe Fishbowl::Requests do
  describe "#get_receipt" do
    before :each do
      mock_tcp_connection
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }

    let(:valid_options) {
      #TODO Identify valid options
    }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.get_receipt(valid_options)
      connection.last_write.should be_equivalent_to(expected_request)
    end

    def expected_request
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.GetReceiptRq {
              #TODO Figure out what goes here!
            }
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.GetReceiptRs(statusCode: '1000', statusMessage: "Success!") {
            #TODO figure out what goes here!
          }
        }
      end
    end
  end
end
