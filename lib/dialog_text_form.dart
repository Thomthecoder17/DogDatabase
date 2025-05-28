import 'package:flutter/material.dart';

//Creates a DialogTextForm widget
class DialogTextForm extends StatefulWidget {
  final int formFields;
  final String promptTemplate;

  //Sets the instance varables for DialogTextForm
  const DialogTextForm({
    super.key,
    required this.formFields,
    required this.promptTemplate,
  });

  @override
  DialogFormState createState() => DialogFormState();
}

//Creates the state class for DialogTextForm. 
//Contains all of the actual form fields and UI elements, as well as data processing.
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
