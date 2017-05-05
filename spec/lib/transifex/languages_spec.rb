require "spec_helper"

describe Transifex::Languages do
  describe "Fetch" do
    it "should fetch information aviyt all languages" do
      VCR.use_cassette "language/fetch_languages_info" do
        info = Transifex::Languages.fetch
        expect(info).to be_an Array
        expect(info.first.keys).to eq(["rtl", "pluralequation", "code", "name", "nplurals"])
      end
    end
  end
end
