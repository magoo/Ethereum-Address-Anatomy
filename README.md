#Anatomy of an Ethereum Address

This script outputs the step by step creation of an Ethereum address. This is an academic approach, would not advise using this for paper wallets or for actual imports into a wallet. Consider this code very unsafe, especially because of the state of SHA3 dependencies. 
##Example Output

1. Private Key (No Hex): 30594893532191419170483904360138267329943395403786937494850298450853451941303
2. Private Key (Hex): 43A41898B13B5F29CA522121FCB32B169C62A3FB0CDA6D0FD90E33310AB245B7
3. Public Key (Hex): 047CD62D1BACE6AB7ECB4620218903A30C33BC05F50522E96349E31780E8DE4E2E22950F3BD4CC2D5A2E7940CA700CA22265D9F477973322A2ED84E7E0E32605B8
4. Strip leading pubkey byte: 7cd62d1bace6ab7ecb4620218903a30c33bc05f50522e96349e31780e8de4e2e22950f3bd4cc2d5a2e7940ca700ca22265d9f477973322a2ed84e7e0e32605b8
4. Keccak-256 (Public Key): 4aac99bda2f7cdc1564d90f12407e85967f2c56298a3c5e51627a42240aa6536
5. Last 20 Bytes: 2407e85967f2c56298a3c5e51627a42240aa6536
6. Address: 0x2407e85967f2c56298a3c5e51627a42240aa6536

##Dependencies
See comments regarding the nebulous state of SHA3 and Ethereum. If the following gem is ever updated to the FIPS standard, this script will break.

`gem install digest-sha3`

##Roadmap
Not going to update this unless a better Keccek-256 gem appears that is designed for Ethereum usage.
