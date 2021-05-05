
import 'package:flutter/material.dart';
import 'movableObject.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class EmojiMetadata{
  String emoji;
  List<double> matrixArguments;
  GlobalKey<MoveableStackItemState> key;

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
  bool hoveringOverTrashCan;

  Color currentColors;
  RenderBox currentConstraints;  

  
  void appendEmoji(MoveableStackItem item){
    EmojiMetadata metadata = item.getMetaData();
    metadata.key = item.key;
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

  void removeEmojiAtLongpress(MoveableStackItem item){
    setState(() {
      ///DODGED
      /// Whichever emoji is pressed, the emoji created last will be removed.
      this.currentEmojis.removeAt(currentEmojis.length-1);

      //EmojiMetadata metadata = item.getMetaData();
      this.currentMetaData.removeAt(currentMetaData.length-1);
      });
  }

  void trashcan(){
    setState(() {
      if(currentEmojis[currentEmojis.length-1].key.currentState.currentPosition.dy > 300){
        this.hoveringOverTrashCan = true;
      }
    });
    
  }


  @override
  void initState() {
    currentEmojis = [];
    currentMetaData = [];
    hoveringOverTrashCan = false;
    for(int i=0; i<widget.emojis.length; i++){
      appendEmoji(widget.emojis[i]);
    }
    currentColors = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<GestureDetector> emojisOnCanvas = [];
    for ( var i in currentEmojis ){
      var item = GestureDetector(
        child: i,
        onTap: (){
          setState(() {
            print("tappe");
            currentEmojis.removeWhere((item){
              return item.key == i.key;
            });
            currentEmojis.add(i); 

            currentMetaData.removeWhere((metadata){
              return metadata.key == i.key;
            });
            currentMetaData.add(i.emojiMetadata); 
          });
          
          //i.key
        },
        /*
        onLongPress: (){
          print("pressing");
          setState(() {
            removeEmojiAtLongpress(i);
          });
        },*/
      );
      emojisOnCanvas.add(item);
    }

    print("width of edit canvas: " +(MediaQuery.of(context).size.width).toString());
    print("height of edit canvas: " +(MediaQuery.of(context).size.height).toString());
    bool accepted = false;
      return 
      MatrixGestureDetector(
        onMatrixUpdate: (m, tm, sm, rm) {
          
          if(currentEmojis.length > 0){
            print("IN MATRIX DETECT");
            setState(() {
              Matrix4 currentMatrix = currentEmojis[currentEmojis.length-1].key.currentState.notifier.value;
              currentMatrix = MatrixGestureDetector.compose(currentMatrix, tm, sm, rm);
              currentEmojis[currentEmojis.length-1].key.currentState.notifier.value = currentMatrix;
              currentMetaData[currentMetaData.length-1].matrixArguments = currentMatrix.storage;
              currentEmojis[currentEmojis.length-1].key.currentState.setState(() {});
            });
          }
        },


        child: Material(
          color: currentColors,
            //height: MediaQuery.of(context).size.width * 0.6,
            //width: //constraints.maxWidth,
            child: Stack(
              children: [
                Positioned(
                  left:50,
                  bottom: 30,
                  child: Container(
                    color: this.hoveringOverTrashCan ? Colors.green : Colors.red,
                    height:100,
                    width:100,
                  ),//trashcan(),
                ),
                  
                Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.hardEdge,
                //alignment: Alignment.center,
                children:  emojisOnCanvas,
                
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
              ]
            ),
              
          ),
      );
      
    
  }
}
