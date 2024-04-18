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

def get_index_by_letter letter
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

def encrypt_letter letter, shift_factor
  return letter unless is_letter?(letter)
  letter_index = (get_index_by_letter(letter) + shift_factor) % 26
  encr_letter_key = get_letter_by_index(letter_index)
  encrypted_letter = is_upcase?(letter) ? encr_letter_key.upcase : encr_letter_key
end

def caesar_cipher string_to_encrypt, shift_factor
  encrypted_string = ""
  string_arr = string_to_encrypt.split ""
  string_arr.each { |letter| encrypted_string += encrypt_letter(letter, shift_factor) }

  puts encrypted_string
end

caesar_cipher "Hello!", 20
