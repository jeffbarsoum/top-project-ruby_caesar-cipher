# frozen_string_literal: true

# get input from user to encrypt / decrypt
module Input
  def input(message)
    puts message
    gets.chomp
  end
end
