
import 'package:flutter/material.dart';
import 'package:skillmill_demo/objects/zoomableObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillmill_demo/objects/emojiKeyboard.dart';

class JournalPost extends StatefulWidget{

  
  @override
  _JournalPost createState() => _JournalPost();
}

class ChosenEmoji {
  static String chosenEmoji;
  static List<Widget> movableEmojis = [];
}

class _JournalPost extends State<JournalPost> {
  String title;
  String emoji;
  List<Widget> emojiList = [];

  //final EmojiKeyboardClass emojiKeyboard;

  //_JournalPost(this.emojiKeyboard);


  @override
  void initState() {
    ChosenEmoji();
    ChosenEmoji.movableEmojis = [];
    emojiList = ChosenEmoji.movableEmojis; 
    super.initState();
  }

  void callback() {
    setState(() {
      this.emojiList = ChosenEmoji.movableEmojis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          
          
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
              height: MediaQuery.of(context).size.height * 0.30,
              child: Card(
                elevation: 10,
                child: Stack(
                  alignment: Alignment.center,
                  children: 
                    ChosenEmoji.movableEmojis,
                  
                  
                  
                ),
              ),
            ),
            
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

