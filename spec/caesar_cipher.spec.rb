# frozen_string_literal: true

require 'caesar_cipher'

describe CaesarCipher do # rubocop:disable Metrics/BlockLength
  # let(:input_dummy_class) { Class.new { extend Input } }
  let(:encryptor) { instance_double(Encryptor) }
  let(:input) { instance_double(Input) }
  subject(:caesar_cipher) { described_class.new(encryptor, input) }

  let(:run_query_msg) { 'Do you want to encrypt or decrypt a message? ([e]ncrypt/[d]ecrypt)' }
  let(:run_input_error) { "Input Error! Please choose 'encrypt'/'decrypt' (or just 'e' / 'd')" }

  before do
    allow(encryptor).to receive(:encrypt)
    allow(encryptor).to receive(:decrypt)
    allow(input).to receive(:get).with(instance_of(String)).and_return(instance_of(String))
  end

  describe '#initialize' do
    # Initialize -> No test necessary
  end

  describe '#run' do # rubocop:disable Metrics/BlockLength
    # Choose -> test loop, 'encrypt', and 'decrypt'

    context "when user executes #run and enters a valid 'encrypt' input" do
      before do
        allow(input).to receive(:get).with(run_query_msg).and_return('e')
        allow(caesar_cipher).to receive(:choose).with('e')
      end
      it 'the input is received, and #choose method is launced with valid input' do
        expect(input).to receive(:get).with(run_query_msg).once
        expect(caesar_cipher).to receive(:choose).with('e').once
        caesar_cipher.run
      end
    end

    context 'when user executes #run and enters an invalid input, followed by a valid #encrypt input' do
      before do
        inputs = ['&', 'e']
        allow(input).to receive(:get).and_return(*inputs)
        allow(caesar_cipher).to receive(:choose).with('e')
      end
      it 'the input is received, and #choose method is launced with the invalid input' do
        expect(input).to receive(:get).with(run_query_msg).once
        expect(input).to receive(:get).with(run_input_error).once
        expect(caesar_cipher).to receive(:choose).with('e')
        caesar_cipher.run
      end
    end

    context 'when user enters 4 invalid inputs and one valid input' do
      before do
        inputs = %w[1 2 3 q d]
        allow(input).to receive(:get).and_return(*inputs)
        allow(caesar_cipher).to receive(:choose).with('d')
      end
      it '4 errors are output to console, followed by a launch of #choose with valid option' do
        expect(input).to receive(:get).with(run_input_error).exactly(4).times
        expect(caesar_cipher).to receive(:choose).with('d').once
        caesar_cipher.run
      end
    end
  end

  describe '#choose' do
    # Choose -> test loop, 'encrypt', and 'decrypt'

    context 'when method launched' do
      it 'launches #encrypt method when called with e' do
        expect(encryptor).to receive(:encrypt).once
        caesar_cipher.choose('e')
      end
      it 'launches #encrypt method when called with encrypt' do
        expect(encryptor).to receive(:encrypt).once
        caesar_cipher.choose('encrypt')
      end
      it 'launches #decrypt method when called with d' do
        expect(encryptor).to receive(:decrypt).once
        caesar_cipher.choose('d')
      end
      it 'launches #decrypt method when called with decrypt' do
        expect(encryptor).to receive(:decrypt).once
        caesar_cipher.choose('decrypt')
      end
      it 'returns nil when no valid input given' do
        expect(encryptor).not_to receive(:encrypt)
        expect(encryptor).not_to receive(:decrypt)
        expect(caesar_cipher).to receive(:choose).and_return(nil)
        caesar_cipher.choose('daflkajflajldfj')
      end
    end
  end
end
