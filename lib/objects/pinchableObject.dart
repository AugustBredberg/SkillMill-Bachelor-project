
import 'package:flutter/material.dart';
import 'package:skillmill_demo/objects/rotateableObject.dart';


class PinchableObject extends StatefulWidget{
  @override
  _PinchableObject createState() => _PinchableObject();



}

class _PinchableObject extends State<PinchableObject>{

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
          minScale: 0.1,
          maxScale: 4.0,
          boundaryMargin: const EdgeInsets.all(double.infinity),
          constrained: false,
          
          child: Container(
            color: Colors.orange,
            width:500,
            height:500,
            constraints: BoxConstraints(
        minHeight: 500,
        minWidth: 500,
        maxHeight: 500,
        maxWidth: 500),
            child: Text("Emoji")), //RotateableObject(),
          /*
           Container(
            //width:100,
            //height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.orange, Colors.red],
                stops: <double>[0.0, 1.0],
              ),
            ),
          ),
          */
        
      
    );
  }
}