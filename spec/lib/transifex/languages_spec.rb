require_relative '../../spec_helper'

describe Transifex::Languages do

  describe "Fetch" do
    it "should fetch all languages infos without raising an error" do
      fetched_languages = nil
      expect{ fetched_languages = Transifex::Languages.fetch }.to_not raise_error
      expect(fetched_languages).to be_a_kind_of(Array)
      expect(fetched_languages.first.keys).to contain_exactly("rtl", "pluralequation", "code", "name", "nplurals")
    end
  end
end