class Dog {
  String name;

  Dog(this.name);

  Dog.fromMap(Map<String, dynamic> map)
      : name = map['name'];

  Map<String, dynamic> toMap() {
    return  {
      'name' : name,
    };
  }
}