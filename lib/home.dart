import 'package:flutter/material.dart';
import 'package:skillmill_demo/newJournal.dart';
import 'objects/cardCarousel.dart';

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
      body: Stack(
          children: [

            Container(
              //padding: EdgeInsets.symmetric(vertical:  MediaQuery.of(context).size.height * 0.05) ,
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: CardCarousel(1.0, 0.95),//JournalFeed()
            ),


            Positioned(
              bottom: 0,
              left: 85,
              child: Container(
                height: 50.0,
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text('New Situation'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          new NewJournal(oldCanvasEmojis: [], oldCanvasColor: Colors.white)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

           

            Container(
              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.10, top: MediaQuery.of(context).size.height * 0.05),
              child: Image.asset("images/skillmill.png"),
                    //Text("Skill Mill",style: TextStyle(fontSize: 80,)),
                ),
          ],
      ),
    );
  }
}
