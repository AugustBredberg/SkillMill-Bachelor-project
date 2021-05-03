

import 'package:flutter/material.dart';
import 'package:skillmill_demo/objects/globals.dart';
import 'emojiCanvas.dart';
import 'package:matrix4_transform/matrix4_transform.dart';


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
      _emojiMetadata.matrixArguments[12],//*(widget.widthOfScreen/editCanvasWidth), // THIS IS THE RATIO BETWEEN THE PREVIEW canvas and the edit canvas
      _emojiMetadata.matrixArguments[13],//*(widget.heightOfScreen/editCanvasHeight),  
      _emojiMetadata.matrixArguments[14],
      _emojiMetadata.matrixArguments[15]
    );
    Matrix4Transform transformed = Matrix4Transform.from(currentMatrix);
    transformed.scale(widget.heightOfScreen/editCanvasHeight);
    
    
    /////// PROBLEM MED ATT ÖVERSÄTTA MATRIX FRÅN EDIT TILL PREVIEW FORTFARANDE 
    ///     TESTADE MED ATT IMPORTARE MATRIX4TRANSFORM, KOLLA METODERNA I DETTA PAKET
    ///
    ///
    ///
    ///
    ///
    print(_emojiMetadata.emoji);
    return Transform(
      //alignment: Alignment.center,
      transform:transformed.matrix4,// currentMatrix,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(_emojiMetadata.emoji, textScaleFactor:2, style: TextStyle(fontSize: 150))
      ),
    );
  }

  

  void updateEmojis(List<EmojiMetadata> metadata){
    setState(() { 
      this.currentEmojis = [];
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
    
    print("Initiated preview canvas");
    currentEmojis = [];
    for(int i=0; i< widget.emojis.length; i++){
      Transform translated = translateMetadataToActualEmoji(widget.emojis[i]);
      currentEmojis.add(translated);
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
          child: ClipRect(
            child: Stack(
              alignment: Alignment.center,
              children: currentEmojis,
            ),
          ),
        );
      } 
    );
  }
}
