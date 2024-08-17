# frozen_string_literal: true

require 'input'
require 'encryptor'
# app to encrypt & decrypt strings
class CaesarCipher
  attr_reader :encryptor, :input

  # Function is essentially an array of letters in order
  def initialize(encryptor = Encryptor.new, input = Input.new)
    @encryptor = encryptor
    @input = input
  end

  def run
    choice = input.get('Do you want to encrypt or decrypt a message? ([e]ncrypt/[d]ecrypt)')
    until %w[d e decrypt encrypt].include?(choice)
      choice = input.get("Input Error! Please choose 'encrypt'/'decrypt' (or just 'e' / 'd')")
    end
    choose(choice)
  end

  def choose(choice)
    encryptor.encrypt if %w[e encrypt].include?(choice)
    encryptor.decrypt if %w[d decrypt].include?(choice)
  end
end
