# frozen_string_literal: true

require 'encryptor'

describe Encryptor do # rubocop:disable Metrics/BlockLength
  # let(:input) { instance_double(Input) }
  # subject(:encryptor) { described_class.new(input) }
  let(:input_message) { 'Please enter the message you want to make super secret (shhh!):' }
  let(:input_shift) { 'Please enter your desired shift parameter (must be 1 or greater!):' }
  let(:input_shift_error) { 'Input Error! Please enter a number that is 1 or greater!' }

  # before do
  #   allow(input).to receive(:get)
  # end
  describe '#initialize' do
    # Initialize -> No test necessary, but will need to test init_alphabet
  end

  describe '#encrypt' do
    # Encrypt -> test 'enter_string', 'shift_factor=', 'encrypted_string='
    let(:input_encrypt) { instance_double(Input, get: 'Hello') }
    subject(:encryptor_encrypt) { described_class.new(input_encrypt) }

    before do
      encrypted_string = 'Mjqqt'
      encrypted_output = "Your encrypted string is (shh!):\n#{encrypted_string}"
      allow(encryptor_encrypt).to receive(:enter_string).with(:encrypt) { encrypted_string }
      allow(encryptor_encrypt).to receive(:shift_factor) { true }
      allow(encryptor_encrypt).to receive(:encrypted_string=) { true }
      allow(encryptor_encrypt).to receive(:encrypted_string) { encrypted_string }
      allow(encryptor_encrypt).to receive(:puts).with(encrypted_output) { encrypted_output }
    end
    context 'when method launched' do
      it 'should receive enter_string' do
        expect(encryptor_encrypt).to receive(:enter_string).with(:encrypt)
      end

      it 'should receive shift_factor' do
        expect(encryptor_encrypt).to receive(:shift_factor)
      end

      it 'should receive #encrypted_string setter' do
        expect(encryptor_encrypt).to receive(:encrypted_string=)
      end
      it 'should receive #puts with encrypted string' do
        output_msg = "Your encrypted string is (shh!):\n#{encryptor_encrypt.encrypted_string}"
        expect(encryptor_encrypt).to receive(:puts).with(output_msg)
      end
      after do
        encryptor_encrypt.encrypt
      end
    end
  end

  describe '#decrypt' do
    # Decrypt -> test 'enter_string', 'shift_factor=', 'decrypted_string='
    let(:input_decrypt) { instance_double(Input, get: 'Mjqqt') }
    subject(:encryptor_decrypt) { described_class.new(input_decrypt) }

    before do
      decrypted_string = 'Hello'
      decrypted_output = "Your decrypted string is (shh!):\n#{decrypted_string}"
      allow(encryptor_decrypt).to receive(:enter_string).with(:decrypt) { decrypted_string }
      allow(encryptor_decrypt).to receive(:shift_factor) { true }
      allow(encryptor_decrypt).to receive(:decrypted_string=) { true }
      allow(encryptor_decrypt).to receive(:decrypted_string) { decrypted_string }
      allow(encryptor_decrypt).to receive(:puts).with(decrypted_output) { decrypted_output }
    end
    context 'when method launched' do
      it 'should receive enter_string' do
        expect(encryptor_decrypt).to receive(:enter_string).with(:decrypt)
      end

      it 'should receive shift_factor' do
        expect(encryptor_decrypt).to receive(:shift_factor)
      end

      it 'should receive #decrypted_string setter' do
        expect(encryptor_decrypt).to receive(:decrypted_string=)
      end
      it 'should receive #puts with decrypted string' do
        output_msg = "Your decrypted string is (shh!):\n#{encryptor_decrypt.decrypted_string}"
        expect(encryptor_decrypt).to receive(:puts).with(output_msg)
      end
      after do
        encryptor_decrypt.decrypt
      end
    end
  end

  describe '#init_alphabet' do
    # Init Alphabet (Private) -> test that @alphabet is populated with
    # letters 'a' to 'z' in order
    let(:input_init_alphabet) { instance_double(Input, get: nil) }
    subject(:encryptor_init_alphabet) { described_class.new(input_init_alphabet) }

    context 'when method launched' do
      it 'populates @alphabet with 26 letters, starting with a and ending with z' do
        expect(encryptor_init_alphabet.alphabet.length).to eq 26
        expect(encryptor_init_alphabet.alphabet.first).to eq 'a'
        expect(encryptor_init_alphabet.alphabet.last).to eq 'z'
      end
    end
  end

  describe '#enter_string' do
    # Input String (Setter) -> test that 'input_string' is set with 'message'

    let(:msg_enter_string) { "Please enter the message you want to #{caller_enter_string} (shhh!):" }
    subject(:encryptor_enter_string) { described_class.new(input_enter_string) }

    context 'when method launched with :encrypt' do
      let(:input_enter_string) { instance_double(Input, get: 'Hello') }
      let(:caller_enter_string) { :encrypt }
      it 'calls Input.#get with ask for message to encrypt' do
        expect(input_enter_string).to receive(:get).with(msg_enter_string)
        encryptor_enter_string.enter_string(:encrypt)

        expect(encryptor_enter_string.input_string).to eq 'Hello'
        encryptor_enter_string.input_string
      end
    end
    context 'when method launched with :decrypt' do
      let(:input_enter_string) { instance_double(Input, get: 'Mjqqt') }
      let(:caller_enter_string) { :decrypt }
      it 'calls Input.#get with ask for message to decrypt' do
        expect(input_enter_string).to receive(:get).with(msg_enter_string)
        encryptor_enter_string.enter_string(:decrypt)

        expect(encryptor_enter_string.input_string).to eq 'Mjqqt'
        encryptor_enter_string.input_string
      end
    end
    context 'when method launched with any other input' do
      let(:input_enter_string) { instance_double(Input, get: nil) }
      let(:caller_enter_string) { :encrypt }
      it 'calls Input.#get with ask for message to decrypt' do
        expect(input_enter_string).not_to receive(:get)
        encryptor_enter_string.enter_string('alkdjfla')

        expect(encryptor_enter_string.input_string).to eq ''
        encryptor_enter_string.input_string
      end
    end
  end

  describe '#cipher' do
    # Cipher -> test 'shift_letter'
    subject(:encryptor_cipher) { described_class.new(double(Input)) }
    # check that decrypted_string is set to 'input'
    # check that string is encrypted for shift factors less than 26
    # check that string is encrypted for shift factors greater than 26
    context 'when lanuched with string input and positive shift factor <= 26' do
      let(:input_cipher) { 'Hello' }
      let(:shift_factor_cipher) { 5 }
      it 'returns the shifted string' do
        expect(encryptor_cipher.cipher(input_cipher, shift_factor_cipher)).to eq 'Mjqqt'
      end
    end

    context 'when lanuched with string input and negative shift factor >= -26' do
      let(:input_cipher) { 'Mjqqt' }
      let(:shift_factor_cipher) { -5 }
      it 'returns the shifted string' do
        expect(encryptor_cipher.cipher(input_cipher, shift_factor_cipher)).to eq 'Hello'
      end
    end

    context 'when lanuched with string input and positive shift factor > 26' do
      let(:input_cipher) { 'Hello' }
      let(:shift_factor_cipher) { 31 }
      it 'returns the shifted string' do
        expect(encryptor_cipher.cipher(input_cipher, shift_factor_cipher)).to eq 'Mjqqt'
      end
    end

    context 'when lanuched with string input and negative shift factor >= -26' do
      let(:input_cipher) { 'Mjqqt' }
      let(:shift_factor_cipher) { -31 }
      it 'returns the shifted string' do
        expect(encryptor_cipher.cipher(input_cipher, shift_factor_cipher)).to eq 'Hello'
      end
    end

    context 'when lanuched with string that has non alphabet character' do
      let(:input_cipher) { 'He1l*' }
      let(:shift_factor_cipher) { 5 }
      it 'returns the shifted string without shifting non-alphabet character' do
        expect(encryptor_cipher.cipher(input_cipher, shift_factor_cipher)).to eq 'Mj1q*'
      end
    end

    context 'when lanuched with non-string' do
      let(:input_cipher) { 83_110 }
      let(:shift_factor_cipher) { 5 }
      it 'raises an error' do
        puts input_cipher
        puts shift_factor_cipher
        expect { encryptor_cipher.cipher(input_cipher, shift_factor_cipher) }.to raise_error(StandardError)
      end
    end
  end

  describe '#encrypted_string=' do
    # Encrypted String (Setter) -> test 'cipher'
    subject(:encryptor_es) { described_class.new(double(Input)) }
    let(:input_es) { 'Hello' }
    let(:shift_factor_es) { 5 }
    let(:cipher_output_es) { 'Mjqqt' }

    # check that decrypted_string is set to 'input'
    # check that cipher is received with input and shift factor

    context 'when method launched with a valid string and shift factor' do
      before(:each) do
        encryptor_es.instance_variable_set(:@shift_factor, shift_factor_es)
        allow(encryptor_es).to receive(:cipher).with(input_es, shift_factor_es).and_return(cipher_output_es)
      end
      it 'sets @decrypted_string to input' do
        encryptor_es.encrypted_string = input_es
        expect(encryptor_es.decrypted_string).to eq input_es
        encryptor_es.decrypted_string
      end
      it 'receives cipher' do
        expect(encryptor_es).to receive(:cipher).with(input_es, shift_factor_es)
        encryptor_es.encrypted_string = input_es
      end
      it 'sets @encrypted_string to output of cipher' do
        encryptor_es.encrypted_string = input_es
        expect(encryptor_es.encrypted_string).to eq cipher_output_es
      end
    end
  end

  describe '#decrypted_string=' do
    # Decrypted String (Setter) ->
    subject(:encryptor_ds) { described_class.new(double(Input)) }
    let(:input_ds) { 'Mjqqt' }
    let(:shift_factor_ds) { 5 }
    let(:cipher_output_ds) { 'Hello' }

    # check that encrypted_string is set to 'input'
    # check that string is decrypted for shift factors less than 26
    # check that string is decrypted for shift factors greater than 26
    context 'when method launched with a valid string and shift factor' do
      before(:each) do
        encryptor_ds.instance_variable_set(:@shift_factor, shift_factor_ds)
        allow(encryptor_ds).to receive(:cipher).with(input_ds, -shift_factor_ds).and_return(cipher_output_ds)
      end
      it 'sets @decrypted_string to input' do
        encryptor_ds.decrypted_string = input_ds
        expect(encryptor_ds.encrypted_string).to eq input_ds
        # encryptor_ds.decrypted_string
      end
      it 'receives cipher' do
        expect(encryptor_ds).to receive(:cipher).with(input_ds, -shift_factor_ds)
        encryptor_ds.decrypted_string = input_ds
      end
      it 'sets @decrypted_string to output of cipher' do
        encryptor_ds.decrypted_string = input_ds
        expect(encryptor_ds.decrypted_string).to eq cipher_output_ds
      end
    end
  end

  describe '#shift_letter' do # rubocop:disable Metrics/BlockLength
    # Shift Letter (Private) ->
    let(:input_shift_letter) { instance_double(Input, get: 'Mjqqt') }
    subject(:encryptor_shift_letter) { described_class.new(input_shift_letter) }

    # check that original character is returned as-is if not in alphabet
    # check that letter is properly shifted for positive shift factors less than 26
    # check that letter is properly shifted for positive shift factors greater than 26
    # check that letter is properly shifted for negative shift factors less than 26
    # check that letter is properly shifted for negative shift factors greater than 26
    # check that shifted letter matches case of original input letter
    context 'when invalid character is entered' do
      it 'return without shifting' do
        expect(encryptor_shift_letter).to receive(:shift_letter).and_return('&')
        encryptor_shift_letter.shift_letter('&', 47)
      end
    end
    context 'when invalid shift factor is entered' do
      it 'returns nil for text' do
        expect { encryptor_shift_letter.shift_letter('&', 'fortyseven') }.to raise_error(NameError)
      end
      it 'raise error for decimals' do
        expect { encryptor_shift_letter.shift_letter('&', 47.1) }.to raise_error(NameError)
      end
    end
    context 'when a valid character and shift factor is entered' do
      it 'returns the shifted letter for positive factors less than 26' do
        expect(encryptor_shift_letter.shift_letter('a', 24)).to eq 'y'
      end
      it 'returns the shifted letter for negative factors less than 26' do
        expect(encryptor_shift_letter.shift_letter('y', -24)).to eq 'a'
      end
      it 'returns the shifted letter for positive factors greater than 26' do
        expect(encryptor_shift_letter.shift_letter('a', 31)).to eq 'f'
      end
      it 'returns the shifted letter for negative factors greater than 26' do
        expect(encryptor_shift_letter.shift_letter('f', -31)).to eq 'a'
      end
    end

    context 'when a valid upper case character and shift factor is entered' do
      it 'returns the upper case shifted letter for positive factors less than 26' do
        expect(encryptor_shift_letter.shift_letter('A', 24)).to eq 'Y'
      end
      it 'returns the upper case shifted letter for negative factors less than 26' do
        expect(encryptor_shift_letter.shift_letter('Y', -24)).to eq 'A'
      end
      it 'returns the upper case shifted letter for positive factors greater than 26' do
        expect(encryptor_shift_letter.shift_letter('A', 31)).to eq 'F'
      end
      it 'returns the upper case shifted letter for negative factors greater than 26' do
        expect(encryptor_shift_letter.shift_letter('F', -31)).to eq 'A'
      end
    end
  end

  describe '#letter?' do
    # Letter? (Private) -> no test necessary
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
