
import 'package:flutter/material.dart';
import 'dart:async';
import 'objects/cardCarousel.dart';

import 'package:flutter_multi_carousel/carousel.dart';


/// THIS IS THE CLASS FOS CREATING THE CAROUSEL WITH FIVE LATEST CARDS. 

class JournalFeed extends StatefulWidget {

  @override
  _JournalFeed createState() => _JournalFeed();
}


class _JournalFeed extends State<JournalFeed>{
  List imageAdresses = [
    "assets/images/log.jpeg",
    "assets/images/jack.png",
    "assets/images/back.png",
    "assets/images/joker.jpg",
    "assets/images/king.jpg",
    "assets/images/queen.png"
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width * 0.95,
        //padding: EdgeInsets.only(left:50),
      child: CardCarousel(imageAdresses)
    );
    
  }
}