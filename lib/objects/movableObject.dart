

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'emojiCanvas.dart';


class MoveableStackItem extends StatefulWidget { 
  EmojiMetadata emojiMetadata;
  Widget givenWidget;
  GlobalKey<MoveableStackItemState> key;

  
  EmojiMetadata getMetaData(){
    if(emojiMetadata != null){ 
      return emojiMetadata; 
    }
    else{ 
      print("EMOJIMETADATA WAS NULL FOR MOVABLE OBJECT"); 
    }
 }

  MoveableStackItem(EmojiMetadata given, GlobalKey givenKey) {
    emojiMetadata = given;
    key = givenKey;

    givenWidget = FittedBox(
        fit: BoxFit.contain,
        child: Text(given.emoji, textScaleFactor:2, style: TextStyle(fontSize: 150))
      );
  }
  
  @override State<StatefulWidget> createState() { 
   return MoveableStackItemState(); 
  } 

}
class MoveableStackItemState extends State<MoveableStackItem> {
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
  EmojiMetadata emojiMetadata;
  Widget givenWidget;
  
  void scaleEmoji(ScaleUpdateDetails scaleDetails) {
    setState(() {
      print('scaleEMojiFUNC');
      //print(notifier.value.row0[0].toString());

      //List<num> newMatrix = notifier.value.storage;
      notifier.value = //MatrixGestureDetector.compose(notifier.value, null, null, null);
      Matrix4(
        this.emojiMetadata.matrixArguments[0]*scaleDetails.scale,
        this.emojiMetadata.matrixArguments[1],
        this.emojiMetadata.matrixArguments[2],
        this.emojiMetadata.matrixArguments[3],
        this.emojiMetadata.matrixArguments[4],
        this.emojiMetadata.matrixArguments[5]*scaleDetails.scale,
        this.emojiMetadata.matrixArguments[6],
        this.emojiMetadata.matrixArguments[7],
        this.emojiMetadata.matrixArguments[8],
        this.emojiMetadata.matrixArguments[9],
        this.emojiMetadata.matrixArguments[10],
        this.emojiMetadata.matrixArguments[11],
        this.emojiMetadata.matrixArguments[12],
        this.emojiMetadata.matrixArguments[13],
        this.emojiMetadata.matrixArguments[14],
        this.emojiMetadata.matrixArguments[15],
        );


        //this.emojiMetadata.matrixArguments = notifier.value.storage;

        //this.emojiMetadata.matrixArguments[0] = scaleDetails.scale;
        //this.emojiMetadata.matrixArguments[5] = scaleDetails.scale;
    });
  }
  void endScale(){
    this.emojiMetadata.matrixArguments = notifier.value.storage;

  }

  @override
  void initState() {
    this.emojiMetadata = widget.emojiMetadata;
    this.givenWidget = widget.givenWidget;
    notifier.value = Matrix4(
      this.emojiMetadata.matrixArguments[0],
      this.emojiMetadata.matrixArguments[1],
      this.emojiMetadata.matrixArguments[2],
      this.emojiMetadata.matrixArguments[3],
      this.emojiMetadata.matrixArguments[4],
      this.emojiMetadata.matrixArguments[5],
      this.emojiMetadata.matrixArguments[6],
      this.emojiMetadata.matrixArguments[7],
      this.emojiMetadata.matrixArguments[8],
      this.emojiMetadata.matrixArguments[9],
      this.emojiMetadata.matrixArguments[10],
      this.emojiMetadata.matrixArguments[11],
      this.emojiMetadata.matrixArguments[12],
      this.emojiMetadata.matrixArguments[13],
      this.emojiMetadata.matrixArguments[14],
      this.emojiMetadata.matrixArguments[15]
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
    return Container(
      width: MediaQuery.of(context).size.height * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: MatrixGestureDetector(
              clipChild: false,
              focalPointAlignment: Alignment.center,
              //shouldTranslate: false,
              onMatrixUpdate: (m, tm, sm, rm) {

                print(rm);
  
                 
                setState(() {
                  /*
                  this.emojiMetadata.matrixArguments[0] *= sm.getColumn(0)[0] * (rm.getColumn(0)[0]).abs(); // scale x
                  this.emojiMetadata.matrixArguments[1] = rm.getColumn(0)[1]; // skew y SOMETHING WITH tan(skewAngle)
                  print("X SKEW IN MATRIX:::::" + this.emojiMetadata.matrixArguments[1].toString());
                  this.emojiMetadata.matrixArguments[2] = 0; 
                  this.emojiMetadata.matrixArguments[3] = 0;
                  this.emojiMetadata.matrixArguments[4] += rm.getColumn(1)[0]; // skew x
                  print("X SKEW IN MATRIX:::::" + this.emojiMetadata.matrixArguments[4].toString());
                  this.emojiMetadata.matrixArguments[5] *= sm.getColumn(1)[1] * (rm.getColumn(1)[1]).abs(); // scale y
                  this.emojiMetadata.matrixArguments[6] = 0; 
                  this.emojiMetadata.matrixArguments[7] = 0;
                  this.emojiMetadata.matrixArguments[8] = 0;  
                  this.emojiMetadata.matrixArguments[9] = 0;
                  this.emojiMetadata.matrixArguments[10] = 1;
                  this.emojiMetadata.matrixArguments[11] = 0;
                  this.emojiMetadata.matrixArguments[12] += tm.getColumn(3)[0] + sm.getColumn(3)[0] + rm.getColumn(3)[0]; //translate x for all the delta matrixes (every matrix updates translate)
                  this.emojiMetadata.matrixArguments[13] += tm.getColumn(3)[1] + sm.getColumn(3)[1] + rm.getColumn(3)[1]; //translate y for all the delta matrixes (every matrix updates translate)
                  this.emojiMetadata.matrixArguments[14] = 0;
                  this.emojiMetadata.matrixArguments[15] = 1;
                  notifier.value.copyFromArray(this.emojiMetadata.matrixArguments);
                  */



                  notifier.value = MatrixGestureDetector.compose(notifier.value, tm, sm, rm);
                  //notifier.value = Matrix4.identity();
                  this.emojiMetadata.matrixArguments = notifier.value.storage;
                });
                
              },
              child: Transform(
                    //alignment: Alignment.center,
                    transform: notifier.value,
                    child: 
                    Container(
                      child: this.givenWidget,
                      color: Colors.blue,
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.width * 1,

                    ),

                  )
                
              
          
        
      ),
    );
  } 
}