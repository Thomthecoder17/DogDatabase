import 'package:dog_database/storage_handler.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dog.dart';

class DogManager extends StatefulWidget {
  const DogManager({super.key});

  final String title = "Add or Remove Dogs";

  @override
  DogManagerState createState() => DogManagerState();
}

class DogManagerState extends State<DogManager> {
  DogStorage storage = DogStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: FutureBuilder(
                      future: storage.readDogLst(),
                      builder: (context, snapshot) {
                        final dogLst = snapshot.data;

                        return ListView.builder(
                          itemCount: dogLst?.length ?? 0,
                          itemBuilder: (context, index) {
                            Dog dog = Dog.fromMap(dogLst?[index]);
                            return ListTile(title: Text(dog.dogName));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(20),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
