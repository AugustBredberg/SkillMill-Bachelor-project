
import 'package:flutter/material.dart';
import 'package:skillmill_demo/objects/zoomableObject.dart';
import 'objects/movableObject.dart';
import 'objects/zoomableObject.dart';


class JournalPost extends StatefulWidget{

  //JournalPost();

  @override
  _JournalPost createState() => _JournalPost();
}



class _JournalPost extends State<JournalPost> {

String title;
String emoji;
List<Widget> movableItems = [];

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          
          
          //mainAxisAlignment: MainAxisAlignment.,
        
          children: [
            
            Container(
              margin: EdgeInsets.only(top:25, left:5, right:5, bottom: 0),
              height: MediaQuery.of(context).size.width * 0.20,      
              child: Center(
                child: Column(
                  children: [
                    Text("Situation context", style: TextStyle(fontSize: 35)),
                    Text("Use symbols to describe the context of the situation", style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left:8, right:8),
              height: 400,
              child: Card(
                elevation: 10,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: 
                    movableItems,
                  
                  
                  
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ElevatedButton(
              onPressed: () {  
                setState(() {
                  movableItems.add(MoveableStackItem());
                  //movableItems.add(ZoomableObject());
                });
              },
              child: Text("Add Emoji", style: TextStyle(fontSize: 30),),
            ),
          ],
        ),
      ),
    );
 
 
  }
}

