# encoding: utf-8
require 'csv'
require 'unicode_utils'

module Wiktionary
  class Noun
    FILES = %w[
      noun
      noun_uncountable
      noun_usually_uncountable
      noun_countable_and_uncountable
      noun_non_attested
      noun_unknown
      noun_pluralia_tantum
      noun_proper
    ]
    PLURALS = %w[noun
      noun_usually_uncountable
      noun_countable_and_uncountable
    ]
    UNCOUNTABLE = 'noun_uncountable'
    PLURALIA_TANTUM = 'noun_pluralia_tantum'

    # Argument path locates directory with CSV files form Wiktionary
    # @param [String] path
    def initialize(path=File.join(File.dirname(__FILE__),'..','..','data/'))
      @plural_to_singulars = Hash.new{|h,e| h[e] = [] }
      @singular_to_plurals = Hash.new{|h,e| h[e] = [] }
      load_files(path)
    end

    # Indicate if noun is in singular form (or uncountable).
    def singular?(noun)
      @singular_to_plurals.has_key?(noun)
    end

    # Indicate if noun is in plural form.
    def plural?(noun)
      @plural_to_singulars.has_key?(noun)
    end

    # Returns list of possible singular forms of noun.
    def singularize(noun)
      first_capital = false
      if noun =~ /^\p{Lu}/
        noun = UnicodeUtils.downcase(noun[0]) + noun[1..-1]
        first_capital = true
      end
      result = @plural_to_singulars[noun]
      if first_capital
        result.map!{|word| UnicodeUtils.upcase(word[0]) + word[1..-1] }
      end
      result
    end

    # Singularize using Wiktionary data. The result is an array of Strings.
    def singularize_name(name, head)
      names = []
      singularized_heads = singularize(head)
      if singularized_heads
        singularized_heads.each do |singularized_head|
          names << name.sub(/\b#{Regexp.quote(head)}\b/, singularized_head)
        end
      end
      names << name if names.empty?
      names
    end

    private

    def load_files(path)
      files = Hash.new
      FILES.each do |file_name|
        files[file_name]=CSV.open(path+'/'+file_name+'.csv')
      end

      PLURALS.each do |file_name|
        files[file_name].each do |singular,*plurals|
          add(singular,plurals)
        end
      end

      files[UNCOUNTABLE].each do |singular|
        add_uncountable(singular.first)
      end

      files[PLURALIA_TANTUM].each do |singular|
        add(singular.first,singular)
      end

      files.each do |_,file|
        file.close
      end
    end

    def add(singular,plurals)
      singular = UnicodeUtils.downcase(singular)
      plurals = plurals.map{|pl| UnicodeUtils.downcase(pl) }
      plurals.each do |plural|
        @plural_to_singulars[plural] << singular unless @plural_to_singulars[plural].include?(singular)
        @singular_to_plurals[singular] << plural unless @singular_to_plurals[singular].include?(plural)
      end
    end

    def add_uncountable(singular)
      singular = UnicodeUtils.downcase(singular)
      @singular_to_plurals[singular] ||= []
    end
  end
end
