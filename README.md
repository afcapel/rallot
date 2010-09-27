README
======

Rallot is a cryptographically secure voting system. It's a Ruby port of the University of Connecticut 
[Adder project](http://www.dagstuhl.de/Materials/Files/07/07311/07311.KiayiasAggelos.Paper.pdf).

It is developed as a Ruby Mendicant University individual project.

GOALS
=====

Rallot has these design goals.

* Transparency. Anyone should be able to review an election process and be sure than the tallying of
votes is accurate.

* Privacy. No one, not even the system administrators, can guess the individual vote of a user. Only
the total results for the election can be known.

* Distributed trust. The system should be supervised by a number of authorities, and the election proccess
can only take place if a qualified mayority of authorities agree. 

HOW IT WORKS
============

The following is a summary of the theory behind Rallot's secure electronic voting system. For a full explanation of
the subject, please refer to the original [Adder paper](http://www.dagstuhl.de/Materials/Files/07/07311/07311.KiayiasAggelos.Paper.pdf).

In order to achive its design goals Rallot uses two cryptographic tools:

### Distributed encryption

In a traditional cryptosystem there are two keys: a public key that is public and a private key that is only know by a particular user. 

Rallot uses a form of distributed ElGamal encryption in which there is a shared public key for the election, but the private key is splitted between the multiple authorities. No single authoritie can decrypt any vote. A qualified majority of authorities must combine their private keys to perform a decryption. 

### Homomorphic encryption

[Homomorphic encrpytion](http://en.wikipedia.org/wiki/Homomorphic_encryption) is a form of encryption that
allows to perfom some operations over encrypted values and obtain the same result than performing the operations
first and the encryption later, that is, encryption(a+b) == encrypytion(a) + encrpytion(b).

This property allow Rallot to operate over encrypted votes and perform their sum before make a decrpytion.

## Election process

When an election starts, a number of authorities are created. They are the entities in charge of the distributed trust of the system and can be operated by politicaly divergent individuals to ensure trustworthiness. Each authority creates a private key and collaborate with the others to generate a public shared key. 

To cast a vote, a user must first athenticate with the system. Then it should send her encrypted vote and a cryptographic proof that the vote is valid -that is, that she has only choose one valid option. The system
check the cryptographic proof and stores the vote and the proof in a central location.

When the election is over, the system add all the encrypted votes and make the result public. Then, each authority, download the encrypted result and make a partial decryption. 

The combination of all this partial decryptions is the final result of the election.   

WORK IN PROGRESS
================

Rallot is yet work in progress.