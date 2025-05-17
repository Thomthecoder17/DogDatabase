import 'package:flutter/material.dart';

class DialogTextForm extends StatefulWidget {
  final int formFields;
  final String promptTemplate;

  const DialogTextForm({
    super.key,
    required this.formFields,
    required this.promptTemplate,
  });

  @override
  DialogFormState createState() =>
      DialogFormState(formFields: formFields, promptTemplate: promptTemplate);
}

class DialogFormState extends State<DialogTextForm> {
  final _formKey = GlobalKey<FormState>();

  int formFields = 0;
  String promptTemplate = '';
  List<String> dogNames = [];

  DialogFormState({required this.formFields, required this.promptTemplate});

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
                    itemCount: formFields,
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
      ),
    );
  }
}
