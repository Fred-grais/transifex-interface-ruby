require_relative '../../spec_helper'

describe Transifex::Language do

  describe "instanciation" do
    it "should raise an error if a language code is not provided" do
      expect { Transifex::Language.new }.to raise_error(Transifex::MissingParametersError)
    end
  end 

  describe "Fetch" do
    it "should fetch the selected language infos without raising an error" do
      fetched_languages = nil
      expect{ fetched_languages = Transifex::Languages.fetch('fr') }.to_not raise_error
      expect(fetched_languages).to be_a_kind_of(Hash)
      expect(fetched_languages.keys).to contain_exactly("rtl", "pluralequation", "code", "name", "nplurals")
    end
  end
end