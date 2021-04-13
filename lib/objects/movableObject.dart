


import 'package:flutter/material.dart';
import 'package:skillmill_demo/objects/pinchableObject.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:zoomer/zoomer.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;


class MoveableStackItem extends StatefulWidget { 
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
        
        /*
        onPanUpdate: (tapInfo) {
          setState(() {
            xPosition += tapInfo.delta.dx;
            yPosition += tapInfo.delta.dy;
          });
        },
        */
        
        onScaleStart: (ScaleStartDetails details) {
          print(details);
          _previousScale = _scale;
          
          setState(() {
            var offset = details.focalPoint;
            xPosition = offset.dx;
            yPosition = offset.dy; 
          });
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          
          //lastRotation += details.rotation;
          


          print(details);
          
          //xPosition = details. focalPoint.dx - xPosition; //  .delta.dx;
          //yPosition = details.focalPoint.dy - yPosition;
          

          setState(() {
            var offset = details.focalPoint;
            xPosition = offset.dx-MediaQuery.of(context).size.width * 0.20;
            yPosition = offset.dy -MediaQuery.of(context).size.width * 0.37; 
            _scale = _previousScale * details.scale;
          });
        },
        onScaleEnd: (ScaleEndDetails details) {
          print(details);
          _previousScale = 1.0;
          //xPosition = details.  .localFocalPoint.dx; //  .delta.dx;
          //yPosition = details.localFocalPoint.dy;
          setState(() {});
        },
        child: RotatedBox(
            quarterTurns: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                child: //Container(height: 100, width: 100, color: Colors.orange,)
                
                Icon(Icons.access_alarms, size: 100),
                //Text("test"),
              ),
            ),
        ),
      
        
        
        /*
        Center(
          child:  Text("🤔", style: TextStyle(fontSize: 30),),//Container(decoration: BoxDecoration(color: Colors.green),height: 150,width: 150),
          */
    
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