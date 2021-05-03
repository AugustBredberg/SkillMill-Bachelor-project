


import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'emojiCanvas.dart';


class MoveableStackItem extends StatefulWidget { 
  EmojiMetadata emojiMetadata;
  Widget givenWidget;
  
  EmojiMetadata getMetaData(){
    if(emojiMetadata != null){ 

      return emojiMetadata;
    }
    else{
      print("EMOJIMETADATA WAS NULL FOR MOVABLE OBJECT");
    }
    
  }

  MoveableStackItem(EmojiMetadata given) {
    emojiMetadata = given;
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

              print(rm);
              //print(m.getColumn(0));
              //print(m.getColumn(1));
              //print(m.getColumn(2));
              //print(m.getColumn(3));
  
               
              
              //notifier.value = m;

              //notifier.value.add(tm);
              //notifier.value.add(sm);
              //notifier.value.add(rm);
              //List<num> newMatrix = m.storage;
              //Matrix4 matrix = Matrix4(, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
              //print(newMatrix);


              //newMatrix.addAll(m.copyIntoArray(newMatrix)) (m.getColumn(0)[1]);

              setState(() {
                this.emojiMetadata.matrixArguments[0] *= sm.getColumn(0)[0]; // scale x
                this.emojiMetadata.matrixArguments[1] += rm.getColumn(0)[1]; // skew y
                this.emojiMetadata.matrixArguments[2] = 0; 
                this.emojiMetadata.matrixArguments[3] = 0;
                this.emojiMetadata.matrixArguments[4] += rm.getColumn(1)[0]; // skew x
                this.emojiMetadata.matrixArguments[5] *= sm.getColumn(1)[1];
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
                print(notifier.value.storage);
              });
              
            },
            child: AnimatedBuilder(
              animation: notifier,
              builder: (ctx, child) {
                return Transform(
                  //alignment: Alignment.center,
                  transform: notifier.value,
                  child: Container(
                    child: this.givenWidget,
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1,

                  ),

                );
              },
            )
        
      
    );
  } 
}