

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
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

  MoveableStackItem(EmojiMetadata given, GlobalKey<MoveableStackItemState> givenKey) {
    this.emojiMetadata = given;
    this.key = givenKey;
    this.givenWidget = FittedBox(
      fit: BoxFit.contain,
      clipBehavior: Clip.none,
      child: Text(given.emoji, textScaleFactor:2, style: TextStyle(fontSize: 150)
    ));
  }
  
  @override State<StatefulWidget> createState() { 
   return MoveableStackItemState(); 
  } 

}
class MoveableStackItemState extends State<MoveableStackItem> {
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
  EmojiMetadata emojiMetadata;
  Widget givenWidget;
  GlobalKey<MoveableStackItemState> myKey;
  Offset currentPosition;
  
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
    this.myKey = widget.key;
    this.emojiMetadata = widget.emojiMetadata;
    this.givenWidget = widget.givenWidget;
    this.currentPosition = Offset(0,0);
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
    //notifier.value = Matrix4.identity();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 1,
      width: MediaQuery.of(context).size.width * 1,
      child: MatrixGestureDetector(
        clipChild: false,
        onMatrixUpdate: (m, tm, sm, rm) {
          //print("moving moving moving");

          
          setState(() {
            if(sm.storage[0]+notifier.value.storage[0] < 0.2){
              notifier.value = MatrixGestureDetector.compose(notifier.value, tm, null, rm);
            }
            else{
              notifier.value = MatrixGestureDetector.compose(notifier.value, tm, sm, rm);
            }
            this.emojiMetadata.matrixArguments = notifier.value.storage;
            Matrix4Transform transformed =Matrix4Transform.from(notifier.value);
            transformed = transformed.scale(0.01);
            this.currentPosition = Offset(transformed.matrix4.storage[12] , transformed.matrix4.storage[13]);
            //this.currentPosition = Offset(this.emojiMetadata.matrixArguments[12] , this.emojiMetadata.matrixArguments[13]*0.5);
            print(this.currentPosition.dx);
            print(notifier.value.storage);
            //print("translate x in preview"+(this.emojiMetadata.matrixArguments[12]).toString());
          });
        },
        child: Transform( 
          transform: notifier.value,
          //alignment: FractionalOffset.center,
          //origin: ,
          child:  this.givenWidget,                      
        )
      ),
    );
  } 
}