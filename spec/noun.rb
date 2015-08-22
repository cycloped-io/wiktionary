$:.unshift "lib"
require 'wiktionary/noun'

RSpec.describe Wiktionary::Noun do
  before(:all) do
    @nouns = Wiktionary::Noun.new
  end

  it "tells if noun is singular" do
    expect(@nouns.singular?("dog")).to eq true
    expect(@nouns.singular?("dogs")).to eq false
    expect(@nouns.singular?("politics")).to eq true
  end

  it "tells if noun is plural" do
    expect(@nouns.plural?("dogs")).to eq true
    expect(@nouns.plural?("oxen")).to eq true
    expect(@nouns.plural?("dog")).to eq false
    expect(@nouns.plural?("abidingness")).to eq false
  end

  it "returns singular form of a noun" do
    expect(@nouns.singularize("dogs")).to include "dog"
    expect(@nouns.singularize("boxes")).to include "box"
    expect(@nouns.singularize("politics")).to include "politics"
    expect(@nouns.singularize("oxen")).to include "ox"
    expect(@nouns.singularize("feet")).to include "foot"
    expect(@nouns.singularize("Dogs")).to include "Dog"
    expect(@nouns.singularize("Γ rays")).to include "Γ ray"
  end
end
