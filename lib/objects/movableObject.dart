


import 'package:flutter/material.dart';
import 'package:skillmill_demo/journalPost.dart';
import 'package:skillmill_demo/objects/pinchableObject.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

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
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
    return MatrixGestureDetector(
        onMatrixUpdate: (m, tm, sm, rm) {
          notifier.value = m;
        },
        child: AnimatedBuilder(
          animation: notifier,
          builder: (ctx, child) {
            return Transform(
              transform: notifier.value,
              child: widget.givenWidget
            
            );
          },
        )
    
    /*
    Positioned(
      top: yPosition,
      left: xPosition,
      child: GestureDetector(
        
        
        onPanUpdate: (tapInfo) {
          setState(() {
            xPosition += tapInfo.delta.dx;
            yPosition += tapInfo.delta.dy;
          });
        },
        
        
        child: Transform(
                //alignment: FractionalOffset.center,
                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                child: widget.givenWidget,
           
        ),
      
        
      ),

      */
      ////////////////////////////////////////////////////////////////////////////////7

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

    );
  } 
}