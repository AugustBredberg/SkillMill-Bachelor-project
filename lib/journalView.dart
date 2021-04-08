import 'package:flutter/material.dart';
import 'journalFeed.dart';
import 'journalPost.dart';


class JournalView extends StatefulWidget {
  //JournalView({Key key, this.title}) : super(key: key);

  String name;
  
  JournalView(name) {
    this.name = name;
  }
  @override
  _JournalView createState() => _JournalView();
}



class _JournalView extends State<JournalView> {

@override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text(widget.name)),
      ),
      body: new JournalFeed(),
          
        
      
      
        
      
      floatingActionButton: Container(
        height: 60,
        width: 150,
        padding: EdgeInsets.all(10.0),
        child: ElevatedButton(
          ///////////////
          /// Style-raden är galen för att elevatedButton behöver ändra state för att byta färg.
          ///////////////
          style: ButtonStyle( backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {return Colors.orange;})),
          child: Center(child: Text("New Entry", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new JournalPost()),
          );
        },
        ),
      )
      
      /*FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

      */
    );
  }
}