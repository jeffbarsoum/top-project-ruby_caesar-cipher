# frozen_string_literal: true

# get input from user to encrypt / decrypt
class Input
  def get(message)
    puts message
    gets.chomp
  end
end
