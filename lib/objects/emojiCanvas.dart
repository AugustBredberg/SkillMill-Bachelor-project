import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'movableObject.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class EmojiMetadata {
  String emoji;
  List<double> matrixArguments;
  GlobalKey<MoveableStackItemState> key;

  EmojiMetadata(String emoji, List<double> args) {
    this.emoji = emoji;
    this.matrixArguments = args;
  }
}

class EmojiCanvas extends StatefulWidget {
  List<MoveableStackItem> emojis;
  Color color;

  EmojiCanvas({Key key, @required this.emojis, @required this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => EmojiCanvasState();
}

class EmojiCanvasState extends State<EmojiCanvas> {
  List<MoveableStackItem> currentEmojis;
  List<EmojiMetadata> currentMetaData;
  bool hoveringOverTrashCan;
  bool shouldShowTrashCan;
  GlobalKey<MoveableStackItemState> hoveringKey;
  Offset fingerPosition;
  List<Offset> fingerPositions = [];
  MoveableStackItem focusEmoji;

  Color currentColors;
  RenderBox currentConstraints;

  void appendEmoji(MoveableStackItem item) {
    EmojiMetadata metadata = item.getMetaData();
    metadata.key = item.key;
    setState(() {
      currentEmojis.add(item);
      currentMetaData.add(metadata);
    });
  }

  void appendColor(Color color) {
    setState(() {
      currentColors = color;
    });
  }

  void trashcan() {
    setState(() {
      /// gör så att så fort man nuddar en emoji hamnar den högst upp i listan ALLTID.
      /// multiplicera currentPosition med emojins 1/scale för att fixa offsets när de är stora och små
      if(fingerPosition.dx > MediaQuery.of(context).size.width *0.35 &&
         fingerPosition.dx < MediaQuery.of(context).size.width *0.75 &&
         fingerPosition.dy > MediaQuery.of(context).size.height*0.90 &&
         currentEmojis[currentEmojis.length-1].key.currentState.currentPosition.dy > MediaQuery.of(context).size.height*0.5
         ){
      //if(currentEmojis[currentEmojis.length-1].key.currentState.currentPosition.dy > MediaQuery.of(context).size.height*0.7){
        this.hoveringOverTrashCan = true;
        this.hoveringKey = currentEmojis[currentEmojis.length - 1].key;
      } else {
        this.hoveringOverTrashCan = false;
      }
    });
  }

  Icon drawTrashCan(){
    if(this.shouldShowTrashCan){

      if(this.hoveringOverTrashCan){
        return Icon(Icons.delete_forever_outlined, size: 80);
      }
      return Icon(Icons.delete_outlined, size: 40);
    }
    else{
      return Icon(Icons.directions_train_sharp, size:0);
    }
  }

  @override
  void initState() {
    currentEmojis = [];
    currentMetaData = [];
    hoveringOverTrashCan = false;
    shouldShowTrashCan = false;
    fingerPosition = Offset(0, 0);
    for (int i = 0; i < widget.emojis.length; i++) {
      appendEmoji(widget.emojis[i]);
    }
    currentColors = widget.color;
    super.initState();
  }

  MoveableStackItem findClosestEmoji() {
    //calculate middle position of fingers
    Offset finger1 = fingerPositions[0];
    Offset finger2 = fingerPositions[1];

    double xMiddlePoint = (((finger1.dx + finger2.dx) / 2)); //72
    double yMiddlePoint = (((finger1.dy + finger2.dy) / 2));
    Offset middlePointFingers = Offset(xMiddlePoint, (yMiddlePoint));
    double distance;
    MoveableStackItem closestEmoji;
    //loop through emojis

    for (int i = 0; i < currentEmojis.length; i++) {
      Offset emojiPosition = Offset(
          currentEmojis[i].emojiMetadata.matrixArguments[12] +
              MediaQuery.of(context).size.width *
                  0.5 *
                  currentEmojis[i].emojiMetadata.matrixArguments[0],
          currentEmojis[i].emojiMetadata.matrixArguments[13] +
              MediaQuery.of(context).size.height *
                  0.5 *
                  currentEmojis[i].emojiMetadata.matrixArguments[0]);
      print(currentEmojis[i].emojiMetadata.matrixArguments[0].toString() +
          ' <- 0 ] 5 ->' +
          currentEmojis[i].emojiMetadata.matrixArguments[5].toString());
      print('  EMOJIPOSITION  ' +
          emojiPosition.toString() +
          currentEmojis[i].emojiMetadata.emoji.toString() +
          '      ' +
          i.toString());
      print('  MIDDLE POINT FINGERS  ' +
          middlePointFingers.toString() +
          '      ' +
          i.toString());
      //Mathematical comparison to define closest
      if (distance == null) {
        distance = (middlePointFingers - emojiPosition).distance;
        closestEmoji = currentEmojis[i];
      }
      print((middlePointFingers - emojiPosition).distance.toString() +
          '  DISTANCE');

      if ((middlePointFingers - emojiPosition).distance < distance) {
        distance = (middlePointFingers - emojiPosition).distance;
        closestEmoji = currentEmojis[i];
      }
    }
    //Return closest emoji
    print(closestEmoji.emojiMetadata.emoji.toString() + ' CLOSEST    EMOJI  ');
    double distanceLimit = (MediaQuery.of(context).size.height * 0.1)+(MediaQuery.of(context).size.width * 0.1)/2;
    if (distance < distanceLimit) {
      return closestEmoji;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<GestureDetector> emojisOnCanvas = [];
    for (var i in currentEmojis) {
      var item = GestureDetector(
        onTap: (){
          setState(() {
          ///////////////////////            
          });
          currentEmojis.removeWhere((item){
              return item.key == i.key;
            });
            currentEmojis.add(i); 
            currentMetaData.removeWhere((metadata){
              return metadata.key == i.key;
            });
            currentMetaData.add(i.emojiMetadata); 
        },
        child: Opacity(
            opacity:
                this.hoveringOverTrashCan && hoveringKey == i.key ? 0.5 : 1,
            child: i),
      );
      /////////////////////////////////////////////////////////////////////////////////
      //// THIS LISTENER WILL PLACE THE MOST RECENTLY MOVED EMOJI ON TOP OF THE STACK
      /////////////////////////////////////////////////////////////////////////////////
      if (i != null && i.key.currentState != null) {
        i.key.currentState.notifier.addListener(() {
          if (currentEmojis[currentEmojis.length - 1].key != i.key) {
            currentEmojis.removeWhere((item) {
              return item.key == i.key;
            });
            currentEmojis.add(i);
            currentMetaData.removeWhere((metadata) {
              return metadata.key == i.key;
            });
            currentMetaData.add(i.emojiMetadata);
          }
        });
      }
      emojisOnCanvas.add(item);
    }

    /*print("width of edit canvas: " +
        (MediaQuery.of(context).size.width).toString());
    print("height of edit canvas: " +
        (MediaQuery.of(context).size.height).toString());*/
    return Listener(
      /////////////////////////////////////////////////////////////////////////////////
      //// THESE ON_POINTERS WILL DETERMINE WHETHER AN EMOJI IS BEING TRASHED OR NOT
      /////////////////////////////////////////////////////////////////////////////////
      onPointerMove: (details) {
        this.fingerPosition = details.position;
        if (this.currentEmojis.length > 0) {
          //print("POINTER IS DOWN AND MOVING");
          this.shouldShowTrashCan = true;
          trashcan();
        }
      },
      onPointerUp: (details) {
        //we dont know which pointer is which
        fingerPositions.removeAt(0);
        if (this.currentEmojis.length > 0) {
          setState(() {
            this.shouldShowTrashCan = false;
            if (this.hoveringOverTrashCan) {
              this.currentEmojis.removeLast();
              this.currentMetaData.removeLast();
            }
          });
        }
      },
      onPointerDown: (PointerEvent details) {
        fingerPositions.add(details.position);
        if (this.fingerPositions.length == 2 &&
            this.currentEmojis.length != 0) {
          MoveableStackItem emojiToEdit = findClosestEmoji();
          if (emojiToEdit != null) this.focusEmoji = emojiToEdit;
        } else {
          this.focusEmoji = null;
        }
      },
      child: MatrixGestureDetector(
        onMatrixUpdate: (m, tm, sm, rm) {
          if (currentEmojis.length > 0 && this.fingerPositions.length == 2 && this.focusEmoji != null) {
            print("IN MATRIX DETECT");
            setState(() {
              Matrix4 currentMatrix =
                  focusEmoji.key.currentState.notifier.value;
              currentMatrix =
                  MatrixGestureDetector.compose(currentMatrix, tm, sm, rm);
              focusEmoji.key.currentState.notifier.value = currentMatrix;
              focusEmoji.emojiMetadata.matrixArguments = currentMatrix.storage;
              focusEmoji.emojiMetadata.key.currentState.setState(() {});
            });
          }
        },
        child: Material(
          color: currentColors,
          //height: MediaQuery.of(context).size.width * 0.6,
          //width: //constraints.maxWidth,
          child: Stack(children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child:
                    drawTrashCan(), //this.hoveringOverTrashCan ? Colors.green : Colors.red,
                height: 100,
                width: 100,
              ), //trashcan(),
            ),
            Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.hardEdge,
              //alignment: Alignment.center,
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
          ]),
        ),
      ),
    );
  }
}
