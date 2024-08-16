# frozen_string_literal: true

require 'input'
require 'encryptor'
# app to encrypt & decrypt strings
class CaesarCipher
  attr_reader :encryptor

  include Input

  # Function is essentially an array of letters in order
  def initialize
    @encryptor = Encryptor.new
  end

  def run
    choice = input('Do you want to encrypt or decrypt a message? ([e]ncrypt/[d]ecrypt)')
    choose(choice)
  end

  def choose(choice)
    until %w[d e].include?(choice.chars.first)
      choice = input("Input Error! Please choose 'encrypt'/'decrypt' (or just 'e' / 'd')")
    end
    encryptor.encrypt if choice.chars.first == 'e'
    encryptor.decrypt if choice.chars.first == 'd'
  end
end
