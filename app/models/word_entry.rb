class WordEntry
  attr_reader :name, :jbo_type, :definition, :note, :affixes, :etymologies

  def initialize(word_name, language)
    word = Word.find_by(name: word_name)
    @name = word.name
    @jbo_type = word.jbo_type
    @definition = get_definition(word, language)
    @note = get_note(word, language)
    @affixes = word.affixes.map(&:name)
    @etymologies = etymology_entries(word.etymologies)
  end

  def etymology_entries(etymologies)
    etymologies.map do |etymology|
      EtymologyEntry.new(etymology)
    end
  end

  def get_definition(word, language)
    word.definitions.where(language: language).first.body
  end

  def get_note(word, language)
    word.notes.where(language: language).first.body
  end
end
