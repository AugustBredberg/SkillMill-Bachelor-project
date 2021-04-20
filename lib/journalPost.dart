import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillmill_demo/objects/emojiKeyboard.dart';
import 'package:skillmill_demo/objects/movableObject.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'journalNote.dart';
import 'objects/emojiCanvas.dart';

class JournalPost extends StatefulWidget {
  @override
  _JournalPost createState() => _JournalPost();
}

class EmojisOnStack extends ChangeNotifier{
  static String chosenEmoji;
  static List<MoveableStackItem> movableEmojis = [];
}

class _JournalPost extends State<JournalPost> {
  String title;
  String emoji;
  List<MoveableStackItem> emojiList = [];
  bool isSuccessful;

  //final EmojiKeyboardClass emojiKeyboard;

  //_JournalPost(this.emojiKeyboard);

  @override
  void initState() {
    EmojisOnStack();
    EmojisOnStack.movableEmojis = [];
    emojiList = EmojisOnStack.movableEmojis;
    isSuccessful = false;
    super.initState();
  }

  void callback() {
    //setState(() {
    //this.emojiList = EmojisOnStack.movableEmojis;
    //});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //// width:  20 + 8
            //// height: 10 + 8 + ish50 + 25 = 75 + 18 = 93 %
            Container(
              margin: EdgeInsets.only(top: 25, left: 5, right: 5, bottom: 0),
              height: MediaQuery.of(context).size.height * 0.10,
              child: Center(
                child: Column(
                  children: [
                    Text("Situation context", style: TextStyle(fontSize: 35)),
                    Text("Use symbols to describe the context of the situation",
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
            ),

            ///////////////////////////////////////////
            /// Container for buttons in CREATE POST view.
            ///////////////////////////////////////////
            Container(
              height: MediaQuery.of(context).size.width * 0.08,
              //color: Colors.amber,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                this.emojiList.length != 0
                    ? IconButton(
                        icon: Icon(Icons.undo, size: 30),
                        onPressed: () {
                          setState(() {
                            EmojisOnStack.movableEmojis.removeLast();
                            //this.emojiList = EmojisOnStack.movableEmojis;
                          });
                        },
                      )
                    : Text(''),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                new JournalNote(EmojiCanvas([], []))),
                      );
                    },
                    child: Text("Done")),
                Row(
                  children: [
                    Text("Add rotated emoji"),
                    IconButton(
                      icon: Icon(Icons.add, size: 30),
                      onPressed: () {
                        setState(() {
                          EmojisOnStack.movableEmojis
                              .add(MoveableStackItem(EmojiMetadata("👾", [
                            0.3691091979487912,
                            -0.5389790934653924,
                            0.0,
                            0.0,
                            0.5389790934653924,
                            0.3691091979487912,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            1.0,
                            0.0,
                            -47.092849436353475,
                            75.43127847705173,
                            0.0,
                            1.0
                          ])));
                        });
                      },
                    ),
                  ],
                )
              ]),
            ),
/*
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.green,
                  Colors.blue,
                  Colors.red,
                ],
              )),
              margin: EdgeInsets.only(left: 8, right: 8),
              height: MediaQuery.of(context).size.width * 0.95,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Stack(
                alignment: Alignment.center,
                children: EmojisOnStack.movableEmojis,
              ),
            ),
*/
            Container(
                height: MediaQuery.of(context).size.width * 0.95,
                width: MediaQuery.of(context).size.width * 0.95,
                child: EmojiCanvas([], [])),
            EmojiKeyboardClass(callback),
            /*
            ElevatedButton(
              onPressed: () {  
                setState(() {
                  movableItems.add(MoveableStackItem());
                  //movableItems.add(ZoomableObject());
                });
              },
              child: Text("Add Emoji", style: TextStyle(fontSize: 30),),
            ),

            */
          ],
        ),
      ),
    );
  }
}
