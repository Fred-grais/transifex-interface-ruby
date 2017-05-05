require "spec_helper"

describe Transifex::Formats do
  describe "Fetch" do
    it "should fetch all formats allowed by Transifex" do

      VCR.use_cassette "fetch_formats" do
        formats = Transifex::Formats.fetch
        expect(formats.keys).to include("KEYVALUEJSON", "YML", "TXT")
      end
    end
  end
end
