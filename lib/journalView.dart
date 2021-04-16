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
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Wrap(
                children: [
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim  ",
                    style: TextStyle(fontSize: 18,)   
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                JournalFeed(),


                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ////////////////////////////////////////////////////////////////////////////7
                      /// FORGET BUTTON 
                      ////////////////////////////////////////////////////////////////////////////7
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                           shape: CircleBorder(), 
                           primary: Colors.red[300]
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width:  MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.width * 0.20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Text(
                            'Forget',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        onPressed: () {},
                      ),
                      ////////////////////////////////////////////////////////////////////////////7
                      /// CREATE BUTTON 
                      ////////////////////////////////////////////////////////////////////////////7
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                           shape: CircleBorder(), 
                           primary: Colors.red
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width:  MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Text(
                            'Create',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new JournalPost()),
                          );
                        },
                      ),
                      ////////////////////////////////////////////////////////////////////////////7
                      /// ARCHIVE BUTTON 
                      ////////////////////////////////////////////////////////////////////////////7
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                           shape: CircleBorder(), 
                           primary: Colors.red[300]                    ),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width:  MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.width * 0.20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Text(
                            'Archive',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
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