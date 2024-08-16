# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('.', 'lib') unless
$LOAD_PATH.include?(File.expand_path('.', 'lib'))

require 'caesar_cipher'

# ###############################################################################
# ## Call Function
# ###############################################################################
caesar_cipher = CaesarCipher.new
caesar_cipher.run
