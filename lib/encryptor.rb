# frozen_string_literal: true

require 'input'
# encrypts and decrypts strings, given a shift factor
class Encryptor
  attr_reader :alphabet, :encrypted_string, :decrypted_string

  include Input

  ###############################################################################
  ## Main Class Methods
  ###############################################################################

  def initialize
    @encrypted_string = ''
    @decrypted_string = ''
    init_alphabet
  end

  def encrypt
    input_string
    shift_factor
    self.encrypted_string = @input_string
    puts "Your encrypted string is (shh!):\n#{encrypted_string}"
  end

  def decrypt
    input_string
    shift_factor
    self.decrypted_string = @input_string
    puts "Your decrypted string is (shh!):\n#{decrypted_string}"
  end

  ###############################################################################
  ## Setter Methods
  ###############################################################################

  def input_string
    @input_string = input('Please enter the message you want to make super secret (shhh!):')
  end

  def shift_factor
    @shift_factor = input('Please enter your desired shift parameter (must be 1 or greater!):').to_i
    until @shift_factor.is_a?(Integer) && @shift_factor.positive?
      @shift_factor = input('Please enter a number that is 1 or greater!').to_i
    end
  end

  def encrypted_string=(input)
    @decrypted_string = input
    string_arr = input.split ''
    string_arr.each { |letter| @encrypted_string += shift_letter(letter, @shift_factor) }
  end

  def decrypted_string=(input)
    @encrypted_string = input
    string_arr = input.split ''
    string_arr.each { |letter| @decrypted_string += shift_letter(letter, -@shift_factor) }
  end

  ###############################################################################
  ## Private Helper Methods
  ###############################################################################

  private

  def init_alphabet
    @alphabet = []
    ('a'..'z').each { |letter| alphabet.push(letter) }
  end

  def letter?(char)
    !!alphabet.find_index(char.downcase)
  end

  def shift_letter(char, shift_factor)
    return char unless letter?(char)

    letter_index = get_index_by_letter(char)

    # ".remainder(26)" ensures that if someone enters a number greater than the number of
    # characters in the alphabet, we essentially 'restart' the count from 1
    # eg: 50  26 = 1 remainder 24, so it's the 24th letter
    #
    # We use "remainder" instead of modulo (eg: "% 26") because of how Ruby handles negative
    # numbers with modulo:
    # https://stackoverflow.com/a/16074198
    # Using remainder allows our method to work for both encryption and decryption, in it's treatment
    # of remainders for both positive and negative numbers

    shifted_letter_index = (letter_index + shift_factor).remainder(26)
    encr_letter_key = get_letter_by_index(shifted_letter_index)
    upcase?(char) ? encr_letter_key.upcase : encr_letter_key
  end

  def get_index_by_letter(letter)
    # shift indexes so they don't start at 0, helps with math
    alphabet.find_index(letter.downcase) + 1
  end

  def get_letter_by_index(index)
    alphabet[index - 1]
  end

  def upcase?(letter)
    letter == letter.upcase
  end
end
