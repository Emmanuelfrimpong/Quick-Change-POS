import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickchange_pos/services/user_controller.dart';

Future<Uint8List?> readFileByte(String filePath) async {
  File file = File(filePath);
  Uint8List? bytes;
  await file.readAsBytes().then((value) {
    bytes = Uint8List.fromList(value);
  });
  return bytes;
}

String generateID(WidgetRef ref) {
  const alphabet = 'abcdefghijklmnopqrstuvwxyz';
  final rand = Random();
  final alphaChars =
      List.generate(3, (_) => alphabet[rand.nextInt(alphabet.length)]);
  final numChars = List.generate(4, (_) => rand.nextInt(10));
  final idChars = [...alphaChars, ...numChars];
  String id = idChars.join().toUpperCase();
  while (checkIfUserExist(ref, id)) {
    id = generateID(ref);
  }
  return id;
}

bool checkIfUserExist(WidgetRef ref, String id) {
  var listOfUsers = ref.read(userController);
  List<String> ids = listOfUsers.map((e) => e.userId!).toList();
  return ids.contains(id);
}
