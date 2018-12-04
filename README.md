# DKG
Distributed Key Generator

Based on the Distributed Key Generator from https://crysp.uwaterloo.ca/software/DKG/

White Paper: [Distributed Key Generation in the Wild](https://eprint.iacr.org/2012/377.pdf)

## Prerequisites:
* GNU Multiple Precision Arithmetic Library https://gmplib.org/
  * On Ubuntu execute: sudo apt-get install libgmp-dev
* Other GNU libraries:
  * sudo apt-get install libgnutls-dev libgcrypt-dev
* Pairing Based Cryptography Library: https://crypto.stanford.edu/pbc

## Repository Details:
* src/ -- Source code
* DKG-Executable/ -- Executables that one can use to run the protocol
* PBC/ -- PBC wrapper classes necessary for compiling the source code
