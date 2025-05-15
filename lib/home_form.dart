import 'package:flutter/material.dart';

// ***TRY TO RE IMPLEMENT THIS***

//   Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text(
//           style: TextStyle(
//               fontSize: 25
//           ),
//           'Dog Park: '
//       ),
//       SizedBox(
//         width: 200,
//         height: 50,
//         child: TextField(
//             controller: _controller
//         ),
//       ),
//     ],
//   ),
//
//   Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text(
//         style: TextStyle(
//           fontSize: 25
//         ),
//           'Number of dogs: '
//       ),
//
//       SizedBox(
//         width: 50,
//         height: 50,
//
//         child: TextField(
//           controller: _controller,
//           onSubmitted: (String dogs) async {
//             int? numDogs = int.tryParse(dogs);
//
//             String alertTitle = 'Thanks!';
//             String alertText = 'Your $numDogs dogs have been entered into the database!';
//
//             if(numDogs == null) { // Ensures the user typed a valid integer input (no decimals or alphabetical characters)
//               alertTitle = 'Invalid Entry:';
//               alertText = 'Please try again.';
//             }
//
//             await showDialog<void>(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text(alertTitle),
//                     content: Text(alertText),
//                   );
//                 }
//             );
//
//             _controller.clear(); // Clears the text field for future entries - will probably move this to the earlier if statement
//           },
//         ),
//       )
//     ],
//   )

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
              onPressed: () async{
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Dog Names'),
                        content:
                            Form(
                            key: _formKey,
                            child: SizedBox(
                              width: 400,
                              height: 400,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: ListView.builder(
                                        itemCount: numDogs,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                width: 200,
                                                child: TextFormField(
                                                  onSaved: (value) {
                                                    setState(() {
                                                      dogNames[index] = value ?? '';
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
                                      _formKey.currentState!.save();
                                    },
                                    child: Text('Submit'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      );
                    },
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
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
