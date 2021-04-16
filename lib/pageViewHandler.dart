import 'package:flutter/material.dart';
import 'journalView.dart';
import 'objects/colorPicker.dart';


class PageViewClass extends StatefulWidget {
  @override
  _PageViewClass createState() => _PageViewClass();
}

class _PageViewClass extends State<PageViewClass> {
  PageController _controller = PageController(
    initialPage: 0,
    
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        new JournalView("August" ),
        //new SkillPage(),
        //new ColorPickerDemo()
      ],
    );
  }
}