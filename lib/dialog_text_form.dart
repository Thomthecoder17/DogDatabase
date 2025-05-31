import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_database/dog.dart';
import 'package:flutter/material.dart';


//Idk what kind of half-modularity is going on here - I created this to be a generic dialog form, then made it specific to dogs

class DialogTextForm extends StatefulWidget {
  final int formFields;
  final String promptTemplate;
  final DocumentReference parkDoc;

  const DialogTextForm({
    super.key,
    required this.formFields,
    required this.promptTemplate,
    required this.parkDoc
  });

  @override
  DialogFormState createState() => DialogFormState();
}

class DialogFormState extends State<DialogTextForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> dogNames = [];

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
                                labelText: '${widget.promptTemplate}${index + 1}',
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
