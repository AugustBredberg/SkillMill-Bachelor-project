import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'movableObject.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'globals.dart' as globals;

class EmojiMetadata {
  String emoji;
  List<double> matrixArguments;
  GlobalKey<MoveableStackItemState> key;

  EmojiMetadata(String emoji, List<double> args, GlobalKey<MoveableStackItemState> key) {
    this.emoji = emoji;
    this.matrixArguments = args;
    this.key = key;
  }

  EmojiMetadata.clone(EmojiMetadata metadata): this(metadata.emoji, metadata.matrixArguments, metadata.key);
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

  List<Function> listeners = [];

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
      if (fingerPosition.dx > MediaQuery.of(context).size.width * 0.35 &&
          fingerPosition.dx < MediaQuery.of(context).size.width * 0.75 &&
          fingerPosition.dy > MediaQuery.of(context).size.height * 0.90 &&
          currentEmojis[currentEmojis.length - 1]
                  .key
                  .currentState
                  .currentPosition
                  .dy >
              MediaQuery.of(context).size.height * 0.85) {
        //if(currentEmojis[currentEmojis.length-1].key.currentState.currentPosition.dy > MediaQuery.of(context).size.height*0.7){
        this.hoveringOverTrashCan = true;
        this.hoveringKey = currentEmojis[currentEmojis.length - 1].key;
      } else {
        this.hoveringOverTrashCan = false;
      }
    });
  }

  Icon drawTrashCan() {
    if (this.shouldShowTrashCan) {
      if (this.hoveringOverTrashCan) {
        return Icon(Icons.delete_forever_outlined, size: 80);
      }
      return Icon(Icons.delete_outlined, size: 40);
    } else {
      return Icon(Icons.directions_train_sharp, size: 0);
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
      Matrix4Transform transformed = Matrix4Transform.from(
          currentEmojis[i].key.currentState.notifier.value);
      transformed = transformed.translateOriginalCoordinates(
          x: MediaQuery.of(context).size.width * 0.5,
          y: MediaQuery.of(context).size.height * 0.5);
      Offset emojiPosition = Offset(
          transformed.matrix4.storage[12], transformed.matrix4.storage[13]);
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
    print(closestEmoji.emojiMetadata.emoji.toString() + ' CLOSEST    EMOJI  ');

    double distanceLimit = (MediaQuery.of(context).size.height * 0.11) +
        (MediaQuery.of(context).size.width * 0.1) / 2;
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
        onTap: () {
          setState(() {
            ///////////////////////
          });
          currentEmojis.removeWhere((item) {
            return item.key == i.key;
          });
          currentEmojis.add(i);
          currentMetaData.removeWhere((metadata) {
            return metadata.key == i.key;
          });
          currentMetaData.add(i.emojiMetadata);
        },
        onLongPress: () {
          final RegExp REGEX_EMOJI = RegExp(
              r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
          Iterable<RegExpMatch> matches =
              REGEX_EMOJI.allMatches(i.emojiMetadata.emoji);
          print("matches: " + matches.toString());
          List<double> matrixArgumentsOfEditedItem = i.emojiMetadata.matrixArguments;
          String textAtStartOfEdit = globals.editStateKey.currentState.controller.text;
          globals.editStateKey.currentState.normalKeyboardController.open();
          globals.editStateKey.currentState.controller.text =
              i.emojiMetadata.emoji;
          globals.editStateKey.currentState.keyboardFocusNode.requestFocus();
          var listenerFunction = (){
            setState(() {
              /// IF THE TEXT HAS BEEN UPDATED
              /// Create a copy of the item, but with the new edited text instead of the old
              /// Remove the old item from the list of emojis, and add the new edited item with the same matrixarguments as before the edit
              /// 
              /// PROBLEM: DEN TAR ALLTID BORT DEN SOM LIGGER LÄNGST UPP I STACKEN!!!
              
              if(textAtStartOfEdit != globals.editStateKey.currentState.controller.text){
                /*
                currentEmojis.removeWhere((item){
                  return item.key == i.key;
                });
                */
                var newKey = new GlobalKey<MoveableStackItemState>();
                MoveableStackItem editedItem = MoveableStackItem(
                  EmojiMetadata(globals.editStateKey.currentState.controller.text, matrixArgumentsOfEditedItem, newKey),
                  newKey,
                );
                //editedItem.emojiMetadata.key = GlobalKey<MoveableStackItemState>();

              
                currentEmojis.removeWhere((item){
                  return item.key == i.key;
                });
                currentMetaData.removeWhere((metadata){
                  return metadata.key == i.key;
                });
                //this.currentEmojis.removeLast();
                //this.currentMetaData.removeLast();
                currentEmojis.add(editedItem); 
                currentMetaData.add(editedItem.emojiMetadata);

                
                //editedItem.key.currentState.setState(() {});
                //editedItem.emojiMetadata.key.currentState.setState(() {});
                /*
                currentMetaData.removeWhere((metadata){
                  print("removed metadata from currentMetaData");
                  return metadata.key == i.key;
                });*/
                
                
                
                
                i = editedItem;
              }
            });
          };
          globals.editStateKey.currentState.controller.addListener(listenerFunction);
          this.listeners.add(listenerFunction);
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
        print('                     M OVE               ' +
            fingerPositions.length.toString());
        if (this.currentEmojis.length > 0 && fingerPositions.length < 2) {
          print("POINTER IS DOWN AND MOVING");
          //this.hoveringOverTrashCan = false;

          this.shouldShowTrashCan = true;
          trashcan();
          print('                     M OVE               ');
        }
        else {
          setState(() {
          this.shouldShowTrashCan = false;
          this.hoveringOverTrashCan = false;
          });

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
          if (currentEmojis.length > 0 &&
              this.fingerPositions.length == 2 &&
              this.focusEmoji != null) {
            print("IN MATRIX DETECT");
            setState(() {
              Matrix4 currentMatrix = focusEmoji.key.currentState.notifier.value;
              currentMatrix = MatrixGestureDetector.compose(currentMatrix, tm, sm, rm);
              focusEmoji.key.currentState.notifier.value = currentMatrix;
              focusEmoji.emojiMetadata.matrixArguments = currentMatrix.storage;
              focusEmoji.key.currentState.setState(() {
                              
                            });
              //focusEmoji.emojiMetadata.key.currentState.setState(() {});
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
              ), 
            ),
            Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.hardEdge,
              children: emojisOnCanvas,
            ),
          ]),
        ),
      ),
    );
  }
}
