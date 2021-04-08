
import 'package:flutter/material.dart';
import 'objects/movableObject.dart';


class JournalPost extends StatefulWidget{

  //JournalPost();

  @override
  _JournalPost createState() => _JournalPost();
}



class _JournalPost extends State<JournalPost> {

String title;
String emoji;
List<Widget> movableItems = [];

@override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 500,
            height: 500,
            child: Stack(
              alignment: Alignment.center,
              children: 
                movableItems,
                //MoveableStackItem(),
               //MovableObject(),
                //TextOverImage(),
                //Text(''),
              
              
              
            ),
          ),
          ElevatedButton(
            onPressed: () {  
              setState(() {
                movableItems.add(MoveableStackItem());
              });
            },
            child: Text("nedanför boxern"),
          ),
        ],
      ),
    );
 
 
  }
}

