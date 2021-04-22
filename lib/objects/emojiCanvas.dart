
import 'package:flutter/material.dart';
import 'package:skillmill_demo/journalPost.dart';
import 'package:skillmill_demo/objects/emojiKeyboard.dart';
import 'movableObject.dart';

class EmojiMetadata{
  String emoji;
  List<double> matrixArguments;
  
  

  EmojiMetadata(String emoji, List<double> args){
    this.emoji = emoji;
    this.matrixArguments = args;
  }
}


class EmojiCanvas extends StatefulWidget { 
  final List<MoveableStackItem> emojis;
  final List<Color> colors;
  //final List<MoveableStackItem> currentEmojis;




  EmojiCanvas({Key key, @required this.emojis, @required this.colors}) : super(key: key);

/*
  EmojiCanvas(List<MoveableStackItem> emojis, List<Color> colors) {
    this.emojis = emojis; 
    this.colors = colors;
    
  }*/
  
  @override State<StatefulWidget> createState() => EmojiCanvasState(); 
  

}



class EmojiCanvasState extends State<EmojiCanvas> { 
  List<MoveableStackItem> currentEmojis;
  
  void appendEmoji(MoveableStackItem item){
    setState(() {
      currentEmojis.add(item);      
    });
  }

  LayoutBuilder createPreviewCanvas(){
    return  new LayoutBuilder(
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
            children: currentEmojis,//EmojisOnStack.movableEmojis, 
            //widget.currentEmojis, 
            //
          ),
        );
      } 
    );
  }

  @override
  void initState() {
    currentEmojis = widget.emojis;
    super.initState();
  }

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
            children: currentEmojis,//EmojisOnStack.movableEmojis, 
            //widget.currentEmojis, 
            //
          ),
        );
      } 
    );
  }
}