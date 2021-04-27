
import 'package:flutter/material.dart';
import 'package:skillmill_demo/journalPost.dart';
import 'package:skillmill_demo/objects/emojiKeyboard.dart';
import 'movableObject.dart';
import 'dart:async';

class EmojiMetadata{
  String emoji;
  List<double> matrixArguments;
  
  

  EmojiMetadata(String emoji, List<double> args){
    this.emoji = emoji;
    this.matrixArguments = args;
  }
}


class EmojiCanvas extends StatefulWidget { 
  List<MoveableStackItem> emojis;
  Color color;
  //final RenderBox currentConstraints;
  //final List<MoveableStackItem> currentEmojis;




  EmojiCanvas({Key key, @required this.emojis, @required this.color}) : super(key: key);

/*
  EmojiCanvas(List<MoveableStackItem> emojis, List<Color> colors) {
    this.emojis = emojis; 
    this.colors = colors;
    
  }*/
  
  @override State<StatefulWidget> createState() => EmojiCanvasState(); 
  

}



class EmojiCanvasState extends State<EmojiCanvas> { 
  List<GestureDetector> currentEmojis;
  List<EmojiMetadata> currentMetaData; 

  Color currentColors;
  RenderBox currentConstraints;  
  Timer _everySecond;

  
  void appendEmoji(MoveableStackItem item){
    EmojiMetadata metadata = item.getMetaData();
    var finalItem;
    finalItem = GestureDetector(
      onLongPress: (){
        print("tryckersomfan");
        setState(() {
        this.currentEmojis.remove(finalItem);          
                });
        
      },
      child: item,
    );

    setState(() {
      
      currentEmojis.add(finalItem);  
      currentMetaData.add(metadata);    
    });
  }

  List<MoveableStackItem> getStackItems(){
    List<MoveableStackItem> items;
    for(int i=0; i<currentEmojis.length; i++){
      MoveableStackItem item = this.currentEmojis[0].child;
      items.add(item);
    }
    print(items);
    return items;
  }


  List<EmojiMetadata> getEmojiMetaDataFomCanvas(){
    List<EmojiMetadata> metaDataList= [];

    for(int i=0; i < this.currentEmojis.length; i++){
      MoveableStackItem item;
      item = currentEmojis[i].child;
      metaDataList.add(  item.getMetaData()  );
    }
    return metaDataList;


  }

  void appendColor(Color color){
    setState(() {
      /*_everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now().second.toString();
      });
      });*/
      currentColors = color;      
    });
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

  @override
  void initState() {
    currentEmojis = [];
    currentMetaData = [];
    for(int i=0; i<widget.emojis.length; i++){
      appendEmoji(widget.emojis[i]);
    }
    
    //currentEmojis = widget.emojis;
    //timer = Timer.periodic(Duration(seconds: 15), (Timer t) => checkForNewSharedLists());

    currentColors = widget.color;//.white; 
    super.initState();
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
            children: currentEmojis,//EmojisOnStack.movableEmojis, 
            
          ),
        );
      } 
    );
  }
}
