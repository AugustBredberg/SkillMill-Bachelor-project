import 'package:flutter/material.dart';
import 'package:skillmill_demo/newJournal.dart';
import 'journalFeed.dart';

class Home extends StatefulWidget {
  //JournalView({Key key, this.title}) : super(key: key);

  String name;

  Home(name) {
    this.name = name;
  }
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text("Skill Mill",
                  style: TextStyle(
                    fontSize: 80,
                  )),
            ),
            JournalFeed(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(), primary: Colors.red),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.width * 0.25,
                alignment: Alignment.center,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Text(
                  'New Situation',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          new NewJournal()),
                );
              },
            ),
          ],
        ),
      ),

      /*FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

      */
    );
  }
}
