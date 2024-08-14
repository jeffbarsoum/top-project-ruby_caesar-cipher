# frozen_string_literal: true

require_relative '../lib/caesar_cipher'

describe CaesarCipher do # rubocop:disable Metrics/BlockLength
  describe '#initialize' do
    # Initialize -> No test necessary, but will need to test
    # 'choose' and init_alphabet methods
  end

  describe '#choose' do
    # Choose -> test loop, 'encrypt', and 'decrypt'
  end

  describe '#input' do
    # Input -> only contains 'puts' and 'gets', no test necessary
  end

  describe '#encrypt' do
    # Encrypt -> test 'input_string=', 'shift_factor=', 'encrypted_string='
  end

  describe '#encrypt' do
    # Encrypt -> test 'decrypted_string='
  end

  describe '#input_string=' do
    # Input String (Setter) -> test that 'input_string' is set with 'message'
  end

  describe '#encrypted_string=' do
    # Encrypted String (Setter) -> test 'shift_letter'
    # check that decrypted_string is set to 'input'
    # check that string is encrypted for shift factors less than 26
    # check that string is encrypted for shift factors greater than 26
  end

  describe '#decrypted_string=' do
    # Decrypted String (Setter) ->
    # check that encrypted_string is set to 'input'
    # check that string is decrypted for shift factors less than 26
    # check that string is decrypted for shift factors greater than 26
  end

  describe '#init_alphabet' do
    # Init Alphabet (Private) -> test that @alphabet is populated with
    # letters 'a' to 'z' in order
  end

  describe '#letter?' do
    # Letter? (Private) -> no test necessary
  end

  describe '#shift_letter' do
    # Shift Letter (Private) ->
    # check that original character is returned as-is if not in alphabet
    # check that letter is properly shifted for positive shift factors less than 26
    # check that letter is properly shifted for positive shift factors greater than 26
    # check that letter is properly shifted for negative shift factors less than 26
    # check that letter is properly shifted for negative shift factors greater than 26
    # check that shifted letter matches case of original input letter
  end

  describe '#get_index_by_letter' do
    # Get Index by Letter (Private) -> no test necessary
  end

  describe '#get_letter_by_index' do
    # Get Letter by Index (Private) -> no test necessary
  end

  describe '#upcase?' do
    # Upcase? (Private) -> no test necessary
  end
end
