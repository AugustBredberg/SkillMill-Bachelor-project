
import 'package:flutter/material.dart';
import 'package:skillmill_demo/objects/pinchableObject.dart';


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
    return Positioned(
          left: offset.dx,
          top: offset.dy,
              /*
                child: GestureDetector(
                  
                    onScaleUpdate: (ScaleUpdateDetails details) {
                      setState(() {
                      //touchPositionFromCenter = details.localPosition;
                      //angle = touchPositionFromCenter.direction;
                      newPosition = details.focalPoint;
                      offset = Offset(
                          offset.dx + newPosition.dx, offset.dy + newPosition.dy);
                      newRotation = details.rotation;

                      //newScale = details.scale;
                      //angle = newRotation;
                      });
                    },
                    child: InteractiveViewer(
                      minScale: 0.1,
                      maxScale: 4.0,
                      boundaryMargin: const EdgeInsets.all(double.infinity),
                      constrained: false,


                      child: Transform.rotate(
                        angle: angle,
                        child:Container(width: 500, height:500, child: Text("snurran")),
                ),
              ),
            ),
            ),
            */          
              

          
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                  offset = Offset(
                      offset.dx + details.delta.dx, offset.dy + details.delta.dy);
              });
            },
            child: PinchableObject()),
        
      );
    
  }
}

