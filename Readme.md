# Word conversion rules from Wiktionary

The aim of the project is providing ruls for converting English words and basic
informations about the words morphology. The project is based on the English
Wiktionary thus the descriptions are pretty accurate and include most of the
exceptions (e.g. ox -> oxen).

## Basic usage

Installation:

```
$ gem install wiktionary
```

So far only nouns are supported.

```ruby
require 'wiktionary/noun'

nouns = Wiktionary::Noun.new
nouns.singularize("dogs") #=> ["dog"]
nouns.singularize("oxen") #=> ["ox"]
nouns.singularize("feet") #=> ["foot"]

nouns.singular?("dog")  #=> true
nouns.singular?("dogs") #=> false


nouns.plural?("dog")  #=> false
nouns.plural?("dogs") #=> true
```

The `singularize` method returns an array since there might be more than one
base form of a given plural word.

## Credits

Krzysztof Wróbel (djstrong)
Aleksander Smywiński-Pohl (apohllo)
