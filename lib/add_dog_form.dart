import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_database/dog.dart';
import 'package:flutter/material.dart';
import 'storage_handler.dart';

class AddDogForm extends StatefulWidget {
  final int formFields;
  final DocumentReference parkDoc;

  const AddDogForm({
    super.key,
    required this.formFields,
    required this.parkDoc
  });

  @override
  AddDogFormState createState() => AddDogFormState();
}

class AddDogFormState extends State<AddDogForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> dogNames = [];
  DogStorage storage = DogStorage();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: AlertDialog(
        title: const Text('Dog Names'),

        content: Form(
          key: _formKey,

          child: SizedBox(
            width: 400,
            height: 400,

            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.formFields,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 200,

                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Dog ${index + 1}',
                              ),
                              onSaved: (value) {
                                setState(() {
                                  dogNames.add(value ?? '');
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    dogNames.clear();
                    _formKey.currentState!.save();

                    Navigator.pop(context); //Removes DialogTextForm

                    List<Map<String, dynamic>> dogMapList = []; //List to lump the maps into

                    for(int i = 0; i < widget.formFields; i++) {
                      Dog dog = Dog(dogNames[i]);
                      Map<String, dynamic> dogMap = dog.toMap();
                      dogMapList.add(dogMap);
                    }

                    widget.parkDoc.update({"dogs" : FieldValue.arrayUnion(dogMapList)});
                    storage.writeDogLst(dogMapList);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}