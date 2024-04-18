###############################################################################
## Data Functions
###############################################################################
# Function is essentially an array of letters in order
# We wrap it in a function so we don't have to enter this in each method

def alphabet
  alphabet = [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
  ]
end


###############################################################################
## Helper Functions
###############################################################################
# Used by the main function call to encrypt the string

def get_index_by_letter letter
  # shift indexes so they don't start at 0, helps with math
  alphabet.find_index(letter.downcase) + 1
end

def get_letter_by_index index
  alphabet[index - 1]
end

def is_letter? char
  !!alphabet.find_index(char.downcase)
end

def is_upcase? letter
  letter == letter.upcase
end

def encrypt_letter char, shift_factor
  # if character is not in the dictionary, return it as is and stop processing
  return char unless is_letter?(char)

  # "% 26" ensures that if someone enters a number greater than the number of
  # characters in the alphabet, we essentially 'restart' the count from 1
  # eg: 50  26 = 1 remainder 24, so it's the 24th letter
  letter_index = (get_index_by_letter(char) + shift_factor) % 26
  encr_letter_key = get_letter_by_index(letter_index)
  encrypted_letter = is_upcase?(char) ? encr_letter_key.upcase : encr_letter_key
end


###############################################################################
## Main Function
###############################################################################

def caesar_cipher
  # We get input from the user in terminal for the message to encrypt
  print "Please enter your super secret message (shhh!):"
  string_to_encrypt = gets.chomp

  # And now the shift parameter
  print "Please enter your desired shift parameter (must be 1 or greater!):"
  shift_factor = gets.chomp.to_i
  ## Exit the code and warn the user if they enter negative numbers
  return puts "Please enter a number that is 1 or greater!" unless shift_factor.is_a?(Integer) && shift_factor > 0

  # encrypt the string, one character at a time
  encrypted_string = ""
  string_arr = string_to_encrypt.split ""
  string_arr.each { |letter| encrypted_string += encrypt_letter(letter, shift_factor) }

  puts encrypted_string
end


###############################################################################
## Call Function
###############################################################################
caesar_cipher
