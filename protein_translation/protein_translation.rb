class InvalidCodonError < StandardError
end
#
class Translation
  CODON_PROTEIN = {
    AUG: 'Methionine',    UUU: 'Phenylalanine', UUC: 'Phenylalanine',
    UUA: 'Leucine',       UUG: 'Leucine',       UCU: 'Serine',
    UCC: 'Serine',        UCA: 'Serine',        UCG: 'Serine',
    UAU: 'Tyrosine',      UAC: 'Tyrosine',      UGU: 'Cystine',
    UGC: 'Cystine',       UGG: 'Tryptophan',    UAA: 'STOP',
    UAG: 'STOP',          UGA: 'STOP'
  }

  def self.of_codon(codon)
    CODON_PROTEIN[codon.to_sym]
  end

  def self.get_codons_from_strand(strand)
    @codons = []
    (strand.size / 3).times do
      @codons << strand.slice!(0, 3)
    end
  end

  def self.get_proteins_from_codons
    @proteins = []
    @codons.each do |codon|
      @proteins << of_codon(codon)
    end
  end

  def self.of_rna(strand)
    get_codons_from_strand(strand)

    get_proteins_from_codons

    raise InvalidCodonError if @proteins.any?(&:nil?)

    @proteins.slice!(@proteins.index('STOP'), @proteins.size) if @proteins.include?('STOP')
    @proteins
  end
end

puts Translation.of_rna('CARROT').inspect rescue p 'Your strand is invalid!'
