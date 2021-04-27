
import 'package:flutter/material.dart';
import 'package:skillmill_demo/journalPost.dart';
import 'package:skillmill_demo/objects/emojiKeyboard.dart';
import 'movableObject.dart';
import 'emojiCanvas.dart';

/*
class EmojiMetadata{
  String emoji;
  List<double> matrixArguments;
  
  

  EmojiMetadata(String emoji, List<double> args){
    this.emoji = emoji;
    this.matrixArguments = args;
  }
}*/


class EmojiCanvasPreview extends StatefulWidget { 
  List<EmojiMetadata> emojis;
  Color color;
  //final RenderBox currentConstraints;
  //final List<MoveableStackItem> currentEmojis;

/*
  EmojiCanvasPreview(List<EmojiMetadata> emojis, Color color){
    this.emojis = emojis;
    this.color = color;
  }
*/
  //EmojiCanvasPreview({@required this.emojis, @required this.color})
  EmojiCanvasPreview({Key key, @required this.emojis, @required this.color}) : super(key: key);
/*
  EmojiCanvas(List<MoveableStackItem> emojis, List<Color> colors) {
    this.emojis = emojis; 
    this.colors = colors;
    
  }*/
  
  @override 
  State<StatefulWidget> createState() => EmojiCanvasPreviewState();
  

}



class EmojiCanvasPreviewState extends State<EmojiCanvasPreview> { 
  List<Transform> currentEmojis;
  Color currentColors;
  RenderBox currentConstraints;
  
  Transform translateMetadataToActualEmoji(EmojiMetadata _emojiMetadata){
    Matrix4 currentMatrix = Matrix4(
      _emojiMetadata.matrixArguments[0],
      _emojiMetadata.matrixArguments[1],
      _emojiMetadata.matrixArguments[2],
      _emojiMetadata.matrixArguments[3],
      _emojiMetadata.matrixArguments[4],
      _emojiMetadata.matrixArguments[5],
      _emojiMetadata.matrixArguments[6],
      _emojiMetadata.matrixArguments[7],
      _emojiMetadata.matrixArguments[8],
      _emojiMetadata.matrixArguments[9],
      _emojiMetadata.matrixArguments[10],
      _emojiMetadata.matrixArguments[11],
      _emojiMetadata.matrixArguments[12],
      _emojiMetadata.matrixArguments[13],
      _emojiMetadata.matrixArguments[14],
      _emojiMetadata.matrixArguments[15]
    );
    print(_emojiMetadata.emoji);
    return Transform(
      //alignment: Alignment.center,
      transform: currentMatrix,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(_emojiMetadata.emoji, textScaleFactor:2, style: TextStyle(fontSize: 150))
      ),
    );
    
    
    /*
    super.initState();
    setState(() {
      currentEmojis.add(item);      
    });
    */
  }

  

  LayoutBuilder createPreviewCanvas(){
    return  new LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            alignment: Alignment.center,
            children: currentEmojis,
          ),
        );
      } 
    );
  }

  void updateEmojis(List<EmojiMetadata> metadata){
    setState(() { 
      for(int i=0; i<metadata.length; i++){
        Transform translated = translateMetadataToActualEmoji(metadata[i]);
        currentEmojis.add(translated);
        print(metadata[i].emoji);
      }
    });
    
  }

  void updateColor(Color color){
    setState(() {
      this.currentColors = color;      
    });
  }

  @override
  void initState() {
    print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    currentEmojis = [];
    for(int i=0; i< widget.emojis.length; i++){
      Transform translated = translateMetadataToActualEmoji(widget.emojis[i]);
      currentEmojis.add(translated);
    }
    setState(() {
          
        });
    //currentEmojis = widget.emojis;
    currentColors = widget.color;//.white; 
    //super.initState();
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
           
            children: currentEmojis, 
            //widget.currentEmojis, 
            //
          ),
        );
      } 
    );
  }
}
