import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorage {
  final String pathFromHere;
  LocalStorage({required this.pathFromHere});

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$pathFromHere');
  }
}

class DogStorage extends LocalStorage{
  DogStorage() : super(pathFromHere: 'dogs.json');

  Future<File> writeDogLst(List dogs) async {
    final file = await _localFile;

    return file.writeAsString(jsonEncode(dogs));
  }

  Future<List> readDogLst() async {
    final file = await _localFile;

    return await jsonDecode(await file.readAsString());
  }
}