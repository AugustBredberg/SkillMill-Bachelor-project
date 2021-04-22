
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
  final Color color;
  //final List<MoveableStackItem> currentEmojis;




  EmojiCanvas({Key key, @required this.emojis, @required this.color}) : super(key: key);

/*
  EmojiCanvas(List<MoveableStackItem> emojis, List<Color> colors) {
    this.emojis = emojis; 
    this.colors = colors;
    
  }*/
  
  @override State<StatefulWidget> createState() => EmojiCanvasState(); 
  

}



class EmojiCanvasState extends State<EmojiCanvas> { 
  List<MoveableStackItem> currentEmojis;
  Color currentColors;
  
  void appendEmoji(MoveableStackItem item){
    setState(() {
      currentEmojis.add(item);      
    });
  }

  void appendColor(Color color){
    setState(() {
      currentColors = color;      
    });
  }

  LayoutBuilder createPreviewCanvas(){
    return  new LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        /*
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: currentColors,
            )
          ),
          */
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
    currentColors = Colors.white; 

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        color: currentColors,
        /*
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: currentColors
            )
          ),*/
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