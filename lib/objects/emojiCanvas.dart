
import 'package:flutter/material.dart';
import 'package:skillmill_demo/journalPost.dart';
import 'package:skillmill_demo/objects/emojiKeyboard.dart';




class EmojiCanvas extends StatefulWidget { 
  static List<EmojiMetadata> emojis;
  static List<Color> colors;
  


  EmojiCanvas(List<EmojiMetadata> emojis, List<Color> colors) {
    emojis = emojis;
    colors = colors;
  }
  
  @override State<StatefulWidget> createState() { 
   return _EmojiCanvas(); 
  } 

}
class _EmojiCanvas extends State<EmojiCanvas> { 

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.green,
                Colors.blue,
                Colors.red,
              ],
            )
          ),
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            alignment: Alignment.center,
            children: EmojisOnStack.movableEmojis,
          ),
        );
      } 
    );
  }
}