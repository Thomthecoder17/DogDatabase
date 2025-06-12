import 'package:flutter/cupertino.dart';

class Dog {
  UniqueKey id = UniqueKey();
  String name;

  Dog(this.name);

  Dog.fromMap(Map<String, dynamic> map) : name = map['name'];

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  get dogId {
    return id;
  }
}
