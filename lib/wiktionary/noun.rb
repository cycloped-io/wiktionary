require 'csv'

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
      @plural_to_singulars[noun]
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
      plurals.each do |plural|
        @plural_to_singulars[plural] << singular
        @singular_to_plurals[singular] << plural
      end
    end

    def add_uncountable(singular)
      @singular_to_plurals[singular] ||= []
    end
  end
end
