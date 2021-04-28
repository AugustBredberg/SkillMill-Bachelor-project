
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
    return new LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        color: currentColors,
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [  
              for ( var i in currentEmojis ) GestureDetector(
                child: i,
                onLongPress: (){
                  print("pressing");
                  
                  setState(() {
                    this.currentEmojis.remove(i);  
                    EmojiMetadata metadata = i.getMetaData();
                    this.currentMetaData.remove(metadata);
                    
                   
                  });
                },
              ), 
            ]
          ),
        );
      } 
    );
  }
}
