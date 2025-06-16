import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login_form.dart';

// Create a Form widget.
class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<HomeForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  var parkCollection = FirebaseFirestore.instance.collection("dog_parks");

  String park = '';
  int numDogs = 0;
  List<String> dogNames = [];

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(style: TextStyle(fontSize: 25), 'Dog Park: '),
              SizedBox(
                width: 200,
                height: 50,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      park = value;
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(style: TextStyle(fontSize: 25), 'Number of dogs: '),

              SizedBox(
                width: 100,
                height: 50,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }

                    String dogs = value;
                    int? numDogs = int.tryParse(dogs);

                    if (numDogs == null) {
                      return 'Please enter a valid value';
                    } else {
                      this.numDogs = numDogs;
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () async {
                final context = _formKey.currentContext;

                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  QuerySnapshot querySnapshot =
                      await parkCollection.where('name', isEqualTo: park).get();
                  if (querySnapshot.size > 0) {
                    if (context != null && context.mounted) {
                      // What happens if it is null or not mounted?
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AddDogForm(
                            formFields: numDogs,
                            parkDoc: querySnapshot.docs.first.reference,
                          );
                        },
                      );
                    }
                  } else {
                    if (context != null && context.mounted) {
                      // What happens if it is null or not mounted?
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Invalid Input'),
                            content: const Text(
                              'Please input a valid dog park name',
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }

                  setState(() {
                    _formKey.currentState!.reset(); //Clears the form
                  });
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
