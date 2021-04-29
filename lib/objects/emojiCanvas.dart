
import 'package:flutter/material.dart';
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
  List<MoveableStackItem> emojis;
  Color color;

  EmojiCanvas({Key key, @required this.emojis, @required this.color}) : super(key: key);


  
  @override State<StatefulWidget> createState() => EmojiCanvasState(); 
  

}



class EmojiCanvasState extends State<EmojiCanvas>{ 
  
  List<MoveableStackItem> currentEmojis;
  List<EmojiMetadata> currentMetaData; 

  Color currentColors;
  RenderBox currentConstraints;  

  
  void appendEmoji(MoveableStackItem item){
    EmojiMetadata metadata = item.getMetaData();
    setState(() {
      currentEmojis.add(item); 
      currentMetaData.add(metadata);    
    });
  }

  void appendColor(Color color){
    setState(() {
      currentColors = color;    
    });
  }

  void removeEmojiAtLongpress(MoveableStackItem item){
    setState(() {
      ///DODGED
      /// Whichever emoji is pressed, the emoji created last will be removed.
      this.currentEmojis.removeAt(currentEmojis.length-1);

      //EmojiMetadata metadata = item.getMetaData();
      this.currentMetaData.removeAt(currentMetaData.length-1);
      });
  }

  @override
  void initState() {
    currentEmojis = [];
    currentMetaData = [];
    for(int i=0; i<widget.emojis.length; i++){
      appendEmoji(widget.emojis[i]);
    }
    currentColors = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<GestureDetector> emojisOnCanvas = [];
    for ( var i in currentEmojis ){
      var item = GestureDetector(
        child: i,
        onLongPress: (){
          print("pressing");
          setState(() {
            removeEmojiAtLongpress(i);
          });
        },
      );
      emojisOnCanvas.add(item);
    }

    return new LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        color: currentColors,
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            alignment: Alignment.center,
            children: emojisOnCanvas,
            
            /*[  
              for ( var i in currentEmojis ) GestureDetector(
                child: i,
                onLongPress: (){
                  print("pressing");
                  
                  setState(() {
                    removeEmojiAtLongpress(i);

                  
                   
                  });
                },
              ), 
            ]
            */
          ),
        );
      } 
    );
  }
}
