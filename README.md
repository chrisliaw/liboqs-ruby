# liboqs-ruby

liboqs-ruby is the Ruby wrapper to the [Open Quantum Safe library](https://openquantumsafe.org). The native library was tested against the liboqs at [liboqs](https://github.com/open-quantum-safe/liboqs)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oqs'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install liboqs-ruby

## Usage

OQS mainly only has two group of functions: Key Encapsulation Mechanism (KEM) and Signature (SIG). 

Therefore the Ruby wrapper abstraction is following the liboqs C version as baseline. 

### Key Encapsulation Mechanism (KEM)

For KEM, the API is simple:

1. List all supported KEM PQ algorithms - PQ algorithms can be enable or disabled at compile time so it all depends on the liboqs native library. This API listed down the algorithms which are *supported* as reported by the native library. If you're using your own version of the library, you might have different output. 
```ruby
require 'oqs'

supported_algo = Oqs::KEM.supported_kem_algo
supported_algo.each do |al|
  # al is the algorithm name (string) which is required by subsequent API
  ...
end
```

2. Generate keypair
```ruby
require 'oqs'

ntru = Oqs::KEM.new('NTRU-HPS-4096-821')
pubKey, secretKey = ntru.genkeypair
# note pubKey and secretKey (or private key) is Fiddle::Pointer type and 
# is required to be used by the C API in the subsequent phase.
# Note that pubKey and secretKey are required to be free manually
# Refer spec file for usage
```

3. Key encapsulation - KEM is meant for key encapsulation which similar with Diffie-Hellman kind of key exchange
```ruby
require 'oqs'

sessionKey, cipher = ntru.derive_encapsulation_key(pubKey)
# cipher is required to be sent to recipient end to re-generate the sessionKey at recipient end.
# Returned sessionKey is meant to convert into the final AES (or any other symmetric key) 
# for the actual data encryption
```

4. Key decapsulation - Re-generate the session key from the private key
```ruby
require 'oqs'

sessionKey = ntru.derive_decapsulation_key(cipher, secretKey)
# cipher is given by sender and privKey is the recipient own private key
```

The idea is the sessionKey from derive\_encapsulation\_key() shall be same as the sessionKey from derive\_decapsulation\_key(). That session key shall be the AES key (any other symmetric key) for the data encryption.


### Signature mechanism

Signature mechanism is similar with KEM.

1. List all supported Signature PQ algorithms - It is same as KEM as algorithm can be turned on or off during compile time 
```ruby
require 'oqs'

supported_algo = Oqs::SIG.supported_signature_algo
supported_algo.each do |al|
  # al is the algorithm name (string) which is required by subsequent API
  ...
end
```

2. Generate keypair
```ruby
require 'oqs'

dili = Oqs::SIG.new('Dilithium5')
pubKey, secretKey = dili.genkeypair
# note pubKey and secretKey (or private key) is Fiddle::Pointer type and 
# is required to be used by the C API in the subsequent phase.
# Note that pubKey and secretKey are required to be free manually
# Refer spec file for usage
```

3. Generate data signature 
```ruby
require 'oqs'

# sign data using sender secretKey/private key
signature = dili.sign("this is message", secretKey)
```

4. Verify data signature
```ruby
require 'oqs'

# verify signature with given data using sender public key
res = dili.verify("this is message", signature, pubKey)
# res is boolean to indicate the signature verification is passed or failed
```

spec folder has the necessary API example usage.

## Development Environment

The source code was tested on 
* Linux: Ruby MRI 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86\_64-linux], Linux Mint 20.2 x86\_64, Kernel 5.4.0-81-generic, CMake version 3.16.3, Ninja 1.10.0
* MacOS: Ruby MRI 3.0.1p64 (2021-04-05 revision 0fb782ee38) [x86\_64-darwin20], Mac OS BigSur 11.5, QuadCore Intel Core i7, CMake version 3.21.1, 1.10.2

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

