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

## Data

The `data` directory - contains lists and mappings of noun forms (plural,
singular, countable, etc.). They are used to identify plural forms and
transform plural to singular. Generated from Wiktionary dump using
https://github.com/djstrong/nouns-with-plurals. 

The following files are available:
* `noun.csv` - countable nouns
* `noun_countable_and_uncountable.csv` - e.g. http://en.wiktionary.org/wiki/beers
* `noun_uncountable.csv` - nouns that cannot be used freely with numbers or
  the indefinite article, and which therefore takes no plural form, e.g.
  http://en.wiktionary.org/wiki/lycra
* `noun_usually_uncountable.csv` - e.g. http://en.wiktionary.org/wiki/information
* `noun_unknown.csv` - nouns with unknown or uncertain plural
* `noun_pluralia_tantum.csv` - nouns that do not have singular forms, e.g. http://en.wiktionary.org/wiki/scissors
* `noun_not_attested.csv` - nouns with plural not attested

The following files contain two columns (singular and
plural form): 
* `noun.csv`
* `noun_countable_and_uncountable.csv`
* `noun_usually_uncountable.csv`

## Credits

Krzysztof Wróbel (djstrong)
Aleksander Smywiński-Pohl (apohllo)
