# frozen_string_literal: true

RSpec.describe Oqs do
  it "has a version number" do
    expect(Oqs::VERSION).not_to be nil
  end

  it 'KEM algorithms' do
    algos = Oqs::KEM.supported_kem_algo 
    expect(algos).not_to be_nil

    expect { Oqs::KEM.new("random") }.to raise_exception(Oqs::Error)

    algos.each do |al|

      puts "Testing #{al}"

      kem = Oqs::KEM.new(al)
      pubKey, privKey = kem.genkeypair
      expect(pubKey).not_to be_nil
      expect(privKey).not_to be_nil

      ekey, cipher = kem.derive_encapsulation_key(pubKey)
      dkey = kem.derive_decapsulation_key(cipher, privKey)
      expect(ekey == dkey).to be true

      puts "Shared key size of #{al} is #{dkey.length}"

    end
    
  end

end
