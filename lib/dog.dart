import 'package:flutter/cupertino.dart';

class Dog {
  UniqueKey uniqueKey = UniqueKey();
  int id = 0;

  String name;

  Dog(this.name) {
    id = uniqueKey.hashCode;
  }

  Dog.fromMap(Map<String, dynamic> map) : name = map['name'];

  Map<String, dynamic> toMap() {
    return {'id' : id,
            'name' : name};
  }

  get dogId {
    return id;
  }
  get dogName {
    return name;
  }
}
