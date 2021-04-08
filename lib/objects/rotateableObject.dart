

import 'package:flutter/material.dart';


class RotateableObject extends StatefulWidget{
  @override
  _RotateableObject createState() => _RotateableObject();



}

class _RotateableObject extends State<RotateableObject> {
  double angle = 0.0;

  void _onPanUpdateHandler(DragUpdateDetails details) {
    final touchPositionFromCenter = details.localPosition;
    setState(
      () {
        angle = touchPositionFromCenter.direction;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanUpdate: _onPanUpdateHandler,
        child: Transform.rotate(
          angle: angle,
          child: Text("snurran"),
          ),
        
    );
  }
}


/*
class _RotateableObject extends State<RotateableObject>{

  float angle;

  @override
  void initState() {
    super.initState();
    angle = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
            angle: angle,
            child: GestureDetector(
              onPanUpdate: (details) {
              setState(() {
                  angle = Offset(
                      offset.dx + details.delta.dx, offset.dy + details.delta.dy);
              });
              },
              child: Text("Emoji")
            ),
          );



  }
}
*/