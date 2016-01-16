require 'pry'
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
    upcase_strand = strand.upcase
    @codons = []
    (strand.size / 3).times do
      @codons << upcase_strand.slice!(0, 3)
    end
    @codons
  end

  def self.get_proteins_from_codons
    @proteins = []
    @codons.each do |codon|
      @proteins << of_codon(codon)
    end
    raise InvalidCodonError if @proteins.any?(&:nil?)
  end

  def self.of_rna(strand)
    get_codons_from_strand(strand)

    get_proteins_from_codons

    @proteins.slice!(@proteins.index('STOP'), @proteins.size) if @proteins.include?('STOP')
    @proteins
  end
end

def prompt(message)
  puts "=> #{message}"
end

system 'clear'

puts '*' * 80
puts " Welcome to Protein Translation! ".center(80, '*')
puts '*' * 80

loop do
  prompt "Please enter a strand:"
  strand = gets.chomp

  prompt "Codons: #{Translation.get_codons_from_strand(strand)}"
  prompt "Proteins: #{Translation.of_rna(strand)}" rescue p 'Your strand is invalid!'

  prompt "Do you want to try another strand?"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

puts '*' * 80
puts " Thank you for using Protein Translation! ".center(80, '*')
puts " Good bye! ".center(80, '*')
puts '*' * 80
