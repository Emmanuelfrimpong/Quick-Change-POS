import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';

Future<Uint8List?> readFileByte(String filePath) async {
  File file = File(filePath);
  Uint8List? bytes;
  await file.readAsBytes().then((value) {
    bytes = Uint8List.fromList(value);
  });
  return bytes;
}

String generateID() {
  const alphabet = 'abcdefghijklmnopqrstuvwxyz';
  final rand = Random();
  final alphaChars =
      List.generate(3, (_) => alphabet[rand.nextInt(alphabet.length)]);
  final numChars = List.generate(4, (_) => rand.nextInt(10));
  final idChars = [...alphaChars, ...numChars];
  return idChars.join().toUpperCase();
}
