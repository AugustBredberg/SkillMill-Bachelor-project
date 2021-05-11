import 'package:flutter/material.dart';
import 'package:skillmill_demo/newJournal.dart';
import 'objects/cardCarousel.dart';

class Home extends StatefulWidget {
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
    return Scaffold(
      body: Stack(
          children: [

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                child: CardCarousel(0.7, 0.7),
              ),//JournalFeed()
            ),


            Align(
              alignment: Alignment.bottomCenter,
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

           

            IgnorePointer(
              ignoring: true,
              child: Container(
                padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.10, top: MediaQuery.of(context).size.height * 0.05),
                child: Image.asset("images/skillmill.png"),
                      //Text("Skill Mill",style: TextStyle(fontSize: 80,)),
                  ),
            ),
          ],
      ),
    );
  }
}
