
import 'package:flutter/material.dart';
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
  bool isSuccessful;

  //final EmojiKeyboardClass emojiKeyboard;

  //_JournalPost(this.emojiKeyboard);


  @override
  void initState() {
    ChosenEmoji();
    ChosenEmoji.movableEmojis = [];
    emojiList = ChosenEmoji.movableEmojis; 
    isSuccessful = false;
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
          
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
          children: [
          //// width:  20 + 8
          //// height: 10 + 8 + ish50 + 25 = 75 + 18 = 93 %
                Container(
                  margin: EdgeInsets.only(top:25, left:5, right:5, bottom: 0),
                  height: MediaQuery.of(context).size.height * 0.10,      
                  child: Center(
                    child: Column(
                      children: [
                        Text("Situation context", style: TextStyle(fontSize: 35)),
                        Text("Use symbols to describe the context of the situation", style: TextStyle(fontSize: 15)),
                         
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.undo, size:30),
                        onPressed: (){
                          setState(() {
                            ChosenEmoji.movableEmojis.removeLast();
                            this.emojiList = ChosenEmoji.movableEmojis;
                          });
                        },
                      ),


                    ]
                  ),
           
            ),

            Container(
              margin: EdgeInsets.only(left:8, right:8),
              height: MediaQuery.of(context).size.width * 0.95,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Card(
                margin: EdgeInsets.all(5),
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

