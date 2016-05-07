#!/usr/bin/env ruby

require 'openssl'
require 'digest/sha3'

include OpenSSL

#Make sure you have the right hashing algoritm for Ethereum.
#Ethereum does not use SHA3 despite its extensive documentation and reference in its codebase. It uses an early version of "Keccak"

#This is confusing for three reasons: There is Keccak-256, The NIST FIPS 202 flavor of Keccak, and SHA3-256.
#To test, the string "testing" should result in: 5f16f4c7f149ac4f9510d9cf8cf384038ad348b3bcdc01915f95de12df9d1b02
#https://medium.com/@ConsenSys/are-you-really-using-sha-3-or-old-code-c5df31ad2b0#.c7zveoc1c
#http://ethereum.stackexchange.com/questions/550/which-cryptographic-hash-function-does-ethereum-use

#This has created a standards problem. 

#The gem we use here incorrectly uses Keccak and says it's SHA3, just like Ethereum does. It's unmaintained, which means it will never be "corrected" which is exactly what we want. I don't like this either.

digest = Digest::SHA3.new(256)

#Generate underlying EC / secp256k1 key
key = PKey::EC.new('secp256k1');
key = key.generate_key

#Printing Private Keys
puts "1. Private Key (No Hex): #{key.private_key}"
puts "2. Private Key (Hex): #{key.private_key.to_s(16)}"

ecdsa_pubkey = key.public_key.to_bn.to_s(16)
#Public Key Address.
puts "3. Public Key (Hex): #{ecdsa_pubkey}"

#The golang implementation strips the leading byte of the public key before hashing.
#Documentation claims that the whole pubkey is hashed.
#See: https://github.com/ethereum/go-ethereum/blob/master/crypto/crypto.go#L341
#This step is also special because we are hashing a hex string, not a string, so we pack('H*') it.

#Additional 'gotcha': Slice bytes off after you've converted the hex string into a proper byte array. Otherwise its a shift(?)
prehash_ecdsa_pubkey = [ecdsa_pubkey].pack('H*').slice(1,64)

puts "4. Strip leading pubkey byte: #{prehash_ecdsa_pubkey.unpack('H*')[0]}"

#Use the Keccak-256 hash on the hex string.
keccak_hash = digest.hexdigest(prehash_ecdsa_pubkey)

puts "4. Keccak-256 (Public Key): #{keccak_hash}"

#The last 20 bytes of a Keccak-256 address is an actual Ethereum address.
puts "5. Last 20 Bytes: #{keccak_hash.byteslice(24,40)}"

#Format for Ethereum
puts "6. Address: 0x#{keccak_hash.byteslice(24,40)}"
