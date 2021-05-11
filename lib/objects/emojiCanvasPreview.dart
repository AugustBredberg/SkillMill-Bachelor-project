

import 'package:flutter/material.dart';
import 'emojiCanvas.dart';


class EmojiCanvasPreview extends StatefulWidget { 
  List<EmojiMetadata> emojis;
  Color color;
  double widthOfScreen; 
  double heightOfScreen;

  EmojiCanvasPreview({Key key, @required this.emojis, @required this.color, @required this.widthOfScreen, @required this.heightOfScreen}) : super(key: key);
  
  @override 
  State<StatefulWidget> createState() => EmojiCanvasPreviewState();
}



class EmojiCanvasPreviewState extends State<EmojiCanvasPreview> { 
  List<Transform> currentEmojis;

  List<EmojiMetadata> currentMetadata;
  Color currentColors;
  
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
      _emojiMetadata.matrixArguments[12]*widget.widthOfScreen,// This is the width in a fraction 
      _emojiMetadata.matrixArguments[13]*widget.heightOfScreen,
      _emojiMetadata.matrixArguments[14],
      _emojiMetadata.matrixArguments[15], 
    );
    return Transform(
      transform: currentMatrix,
      child: FittedBox(
        fit: BoxFit.contain,
        clipBehavior: Clip.none,
        child: Text(_emojiMetadata.emoji, textScaleFactor:2, style: TextStyle(fontSize: 150))
      ),
    );
  }

  

  void updateEmojis(List<EmojiMetadata> metadata){
    setState(() { 
      this.currentEmojis = [];
      this.currentMetadata = [];
      for(int i=0; i<metadata.length; i++){
        Transform translated = translateMetadataToActualEmoji(metadata[i]);
        currentEmojis.add(translated);
        currentMetadata.add(metadata[i]);
        print(metadata[i].emoji);
      }
    });
  }

  void updateColor(Color color){
    setState(() {
      this.currentColors = color;   
      widget.color = color;   
    });
  }


  @override
  void initState() {
    currentEmojis = [];
    currentMetadata = [];
    for(int i=0; i< widget.emojis.length; i++){
      Transform translated = translateMetadataToActualEmoji(widget.emojis[i]);
      currentEmojis.add(translated);
      currentMetadata.add(widget.emojis[i]);
    }
    currentColors = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: currentColors,
          child:Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.hardEdge,
            children: [
              for(var curr in currentEmojis) 
              Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                child:  curr
              ),
            ],  
          ), 
      ),
    );
  }
}
