import 'package:flutter/material.dart';
import 'package:skillmill_demo/journalPost.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillmill_demo/home.dart';
import 'package:skillmill_demo/objects/emojiCanvas.dart';
import 'package:skillmill_demo/objects/emojiKeyboard.dart';
import 'package:skillmill_demo/objects/movableObject.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'objects/cardCarousel.dart';

class NewJournal extends StatefulWidget {

  NewJournal() {

  }
  @override
  _NewJournal createState() => _NewJournal();
}

class _NewJournal extends State<NewJournal> {
  EmojiCanvas impact;

  List imageAdresses = [
    "assets/images/log.jpeg",
    "assets/images/jack.png",
    "assets/images/back.png",
    "assets/images/joker.jpg",
    "assets/images/king.jpg",
    "assets/images/queen.png"
  ];

  @override
  void initState() {
    impact = EmojiCanvas([], []);
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Situation")),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.width * 0.05)),
                child: TextField(
                  maxLength: 20,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter situation name",
                  ),
                ),
              ),
              Container(
                child: Center(
                    child: Stack(
                  children: [
                    impact,
                    IconButton(
                      icon: Icon(
                        IconData(59109, fontFamily: 'MaterialIcons'),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JournalPost()),
                        );
                      },
                    ),
                  ],
                )),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.3,
                child: CardCarousel(imageAdresses),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.width * 0.05)),
                child: TextField(
                  maxLength: 250,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Write a short note about your entry",
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Save Entry"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
