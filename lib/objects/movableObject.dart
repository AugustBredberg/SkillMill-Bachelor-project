


import 'package:flutter/material.dart';
import 'package:skillmill_demo/objects/pinchableObject.dart';
import 'package:zoom_widget/zoom_widget.dart';

class MoveableStackItem extends StatefulWidget { 
  @override State<StatefulWidget> createState() { 
   return _MoveableStackItemState(); 
  } 
}
class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;
  Color color;
  @override
  void initState() {
    color = Colors.orange;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition,
      left: xPosition,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            xPosition += tapInfo.delta.dx;
            yPosition += tapInfo.delta.dy;
          });
        },
        child: Center(
    child:  Container(
          width: 150,
          height: 150,
          color: color,
        ),
    
  ),
      ),
    );
  }
}

/*
class MovableObject extends StatefulWidget {
  @override
  _MovableObject createState() => _MovableObject();
}

class _MovableObject extends State<MovableObject> {
  Offset offset = Offset.zero;
  double angle = 0.0;
  Offset newPosition = Offset.zero;
  double newRotation = 0.0;
  double newScale = 0.0;
  Offset touchPositionFromCenter = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height:500,
      child: Positioned(
            left: offset.dx,
            top: offset.dy,
            
              
                child:  GestureDetector(
                    onPanUpdate: (details) {
                    setState(() {
                        offset = Offset(
                            offset.dx + details.delta.dx, offset.dy + details.delta.dy);
                      });
                    },
                    child:
                    InteractiveViewer(
                  minScale: 0.1,
                  maxScale: 4.0,
                  boundaryMargin: const EdgeInsets.all(double.infinity),
                  constrained: false,
                
                 
                  child: Text("Emoji"),//PinchableObject()),
                  ),
                ),
              
            
        ),
    );
    
  }
}

*/