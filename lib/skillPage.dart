

import 'package:flutter/material.dart';
import 'journalFeed.dart';
import 'journalPost.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

/*
class SkillPage extends StatefulWidget {
  //SkillPage({Key key, this.title}) : super(key: key);
  //final String title;

  @override
  _SkillPage createState() => _SkillPage();
}
*/
//class _SkillPage extends State<SkillPage> {
class SkillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              child: Hero(
                tag: 'cognitive',
                child: Row(
                  children: [
                    Icon(Icons.lightbulb, size: 50,),
                    Text("Cognitive competences")
                  ],)
                
                //Image.asset('images/king.jpg'),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailScreen();
                }));
              },
            ),
            GestureDetector(
              child: Hero(
                tag: 'imageHero',
                child: Row(
                  children: [
                    Icon(Icons.person, size: 50,),
                    Text("Inter-personal competences")
                  ],)
                
                //Image.asset('images/king.jpg'),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailScreen();
                }));
              },
            ),

            SizedBox(
    width: 300,
    height:300,
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Card(
        elevation: 2,
        child: ColorPicker(
          // Use the screenPickerColor as start color.
          color: Colors.red,
          // Update the screenPickerColor using the callback.
          pickersEnabled: const <ColorPickerType, bool>{
            //ColorPickerType.both: false,
            //ColorPickerType.primary: true,
            //ColorPickerType.accent: true,
            //ColorPickerType.bw: false,
            //ColorPickerType.custom: true,
            //ColorPickerType.wheel: true,
          },
          onColorChanged: (Color color) {},
            //setState(() => Colors.blue = color),
          width: 44,
          height: 44,
          borderRadius: 22,
          heading: Text(
            'Select color',
            style: Theme.of(context).textTheme.headline5,
          ),
          subheading: Text(
            'Select color shade',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    ),
  ),
          ],
        ),
      ),
    );
  }
}



class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'cognitive',
            child: Container(
              height: 400,
              width: 300,
              child: Card(
                elevation: 10,

              )
            ),
            
            //Image.asset('images/king.jpg'),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}