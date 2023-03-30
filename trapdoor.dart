import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:ninja_prime/ninja_prime.dart';

void main() {
  var bitsize = 8;
  BigInt p = randomPrimeBigInt(bitsize);
  BigInt q = randomPrimeBigInt(bitsize);

  BigInt N = p * q;

  BigInt phiN = (p - BigInt.one) * (q - BigInt.one);

  BigInt etimesd = (randomBigInt(8) * phiN) + BigInt.one;

  List<BigInt> result = [];
  for (BigInt i = BigInt.one; i < etimesd; i += BigInt.one) {
    if (etimesd % i == BigInt.zero) {
      result.add(i);
      result.add(BigInt.from(etimesd / i));
    }
  }

  BigInt e = result[result.length - 1];
  BigInt d = result[result.length - 2] % phiN;

  print("e*d mod phiN = 1: ${(e * d) % phiN == BigInt.one}");

  print("Public key: (${e}, ${N})");
  print("Private key: ${d}");

  print("Insert number you want to encrypt:");
  var line = stdin.readLineSync(encoding: utf8);
  BigInt? msg = BigInt.tryParse(line!);
  if (msg == null) {
    print("Please try again, next time inserting an integer");
    exit(1);
  }

  BigInt m = msg.modPow(e, N);
  print("Encrypted: ${m}");

  BigInt dmsg = m.modPow(d, N);
  print("Decrypted: ${dmsg}");

  print(dmsg == msg);
}
