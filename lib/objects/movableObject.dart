


import 'package:flutter/material.dart';
import 'package:skillmill_demo/journalPost.dart';
import 'package:skillmill_demo/objects/pinchableObject.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;


class MoveableStackItem extends StatefulWidget { 
  Widget givenWidget;

  MoveableStackItem(Widget given) {
    givenWidget = given;
  }
  
  @override State<StatefulWidget> createState() { 
   return _MoveableStackItemState(); 
  } 

}
class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;
  Color color;
  double _scale = 1.0;
  double _previousScale = 1.0;


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
        
        /*
        onScaleStart: (ScaleStartDetails details) {
          print(details);
          
          
          setState(() {
            _previousScale = _scale;
            var offset = details.localFocalPoint;
            //xPosition = offset.dx;
            //yPosition = offset.dy; 
          });
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          
          //lastRotation += details.rotation;
          


          print(details);
          
          //xPosition = details. focalPoint.dx - xPosition; //  .delta.dx;
          //yPosition = details.focalPoint.dy - yPosition;
          

          setState(() {
            var offset = details.localFocalPoint;
            //xPosition = offset.dx; //-MediaQuery.of(context).size.width * 1;
            //yPosition = offset.dy; //-MediaQuery.of(context).size.height * 1; 
            _scale = _previousScale * details.scale;
          });
        },
        onScaleEnd: (ScaleEndDetails details) {
          _previousScale = 1.0;
          //xPosition = details.  .localFocalPoint.dx; //  .delta.dx;
          //yPosition = details.localFocalPoint.dy;
          setState(() {});
        },
        */

        child: Transform(
                //alignment: FractionalOffset.center,
                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                child: widget.givenWidget,
           
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