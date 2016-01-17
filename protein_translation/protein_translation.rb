class InvalidCodonError < StandardError
end

module Translation
  CODON_PROTEIN = {
    'AUG' => 'Methionine',    'UUU' => 'Phenylalanine',
    'UUC' => 'Phenylalanine', 'UUA' => 'Leucine',
    'UUG' => 'Leucine',       'UCU' => 'Serine',
    'UCC' => 'Serine',        'UCA' => 'Serine',
    'UCG' => 'Serine',        'UAU' => 'Tyrosine',
    'UAC' => 'Tyrosine',      'UGU' => 'Cystine',
    'UGC' => 'Cystine',       'UGG' => 'Tryptophan',
    'UAA' => 'STOP',          'UAG' => 'STOP',
    'UGA' => 'STOP'
  }

  def self.of_codon(codon)
    CODON_PROTEIN.fetch(codon) { raise InvalidCodonError }
  end

  def self.of_rna(strand)
    proteins = strand.scan(/.../).map do |codon|
      of_codon(codon)
    end
    proteins.slice!(proteins.index('STOP'), proteins.size) if proteins.include?('STOP')
    p proteins
  end
end
