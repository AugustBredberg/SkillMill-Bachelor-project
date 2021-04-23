


import 'package:flutter/material.dart';
import 'package:skillmill_demo/journalPost.dart';
import 'package:skillmill_demo/objects/pinchableObject.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:skillmill_demo/objects/emojiKeyboard.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'emojiCanvas.dart';
import 'dart:convert';
//import 'dart:io';
//import 'dart:typed_data';
//



class MoveableStackItem extends StatefulWidget { 
  EmojiMetadata _emojiMetadata;
  Widget givenWidget;
  


  MoveableStackItem(EmojiMetadata given) {
    _emojiMetadata = given;
    givenWidget = FittedBox(
        fit: BoxFit.contain,
        child: Text(given.emoji, textScaleFactor:2, style: TextStyle(fontSize: 150))
      );
  }
  
  @override State<StatefulWidget> createState() { 
   return _MoveableStackItemState(); 
  } 

}
class _MoveableStackItemState extends State<MoveableStackItem> {
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());


  @override
  void initState() {
    notifier.value = Matrix4(
      widget._emojiMetadata.matrixArguments[0],
      widget._emojiMetadata.matrixArguments[1],
      widget._emojiMetadata.matrixArguments[2],
      widget._emojiMetadata.matrixArguments[3],
      widget._emojiMetadata.matrixArguments[4],
      widget._emojiMetadata.matrixArguments[5],
      widget._emojiMetadata.matrixArguments[6],
      widget._emojiMetadata.matrixArguments[7],
      widget._emojiMetadata.matrixArguments[8],
      widget._emojiMetadata.matrixArguments[9],
      widget._emojiMetadata.matrixArguments[10],
      widget._emojiMetadata.matrixArguments[11],
      widget._emojiMetadata.matrixArguments[12],
      widget._emojiMetadata.matrixArguments[13],
      widget._emojiMetadata.matrixArguments[14],
      widget._emojiMetadata.matrixArguments[15]
    );
    super.initState();
  }
  

  var json = { 
    "emoji":"🤗",
    "col0":"[0.6463089079186324, 0.13423912881164965, 0.0, 0.0,]",
    "col1":"[-0.13423912881164965,0.6463089079186324, 0.0, 0.0,]",
    "col2":"[0.0, 0.0, 1.0, 0.0,]",
    "col3":"[58.29945312195869, 11.104368977904983, 0.0, 1.0]" };

  
  @override
  Widget build(BuildContext context) {
    /*
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    notifier.value = Matrix4(
      widget._emojiMetadata.matrixArguments[0],
      widget._emojiMetadata.matrixArguments[1],
      widget._emojiMetadata.matrixArguments[2],
      widget._emojiMetadata.matrixArguments[3],
      widget._emojiMetadata.matrixArguments[4],
      widget._emojiMetadata.matrixArguments[5],
      widget._emojiMetadata.matrixArguments[6],
      widget._emojiMetadata.matrixArguments[7],
      widget._emojiMetadata.matrixArguments[8],
      widget._emojiMetadata.matrixArguments[9],
      widget._emojiMetadata.matrixArguments[10],
      widget._emojiMetadata.matrixArguments[11],
      widget._emojiMetadata.matrixArguments[12],
      widget._emojiMetadata.matrixArguments[13],
      widget._emojiMetadata.matrixArguments[14],
      widget._emojiMetadata.matrixArguments[15]
    );
    */
    //print(_attemptOfJsonDecoding());
    //print(presetTest.getColumn(0));
    return MatrixGestureDetector(
            clipChild: true,
            //shouldTranslate: false,
            onMatrixUpdate: (m, tm, sm, rm) {
/*
              print(m.getColumn(0));
              print(m.getColumn(1));
              print(m.getColumn(2));
              print(m.getColumn(3));
  */        
               
              
              notifier.value = m;
              List<num> newMatrix = m.storage;
              
              print(newMatrix);

              //newMatrix.addAll(m.copyIntoArray(newMatrix)) (m.getColumn(0)[1]);

              setState(() {
                widget._emojiMetadata.matrixArguments = newMatrix;
              });
              
            },
            child: AnimatedBuilder(
              animation: notifier,
              builder: (ctx, child) {
                return Transform(
                  //alignment: Alignment.center,
                  transform: notifier.value,
                  child: widget.givenWidget

                );
              },
            )
        
      
    );
  } 
}