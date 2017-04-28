require "spec_helper"

describe Transifex::Language do
  describe "Instantiation" do
    it "should raise an error if a language code is not provided" do
      expect { Transifex::Language.new }.to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: language_code")
    end
  end

  describe "Fetch" do
    it "should fetch the selected language info" do
      VCR.use_cassette "language/fetch_language_info" do
        expect(Transifex::Languages.fetch("fr")).to eq(language_info)
      end
    end
  end
end
