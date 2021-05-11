import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skillmill_demo/objects/emojiCanvas.dart';
import 'package:skillmill_demo/objects/emojiCanvasPreview.dart';
import 'emojiCanvasPreview.dart';
import 'globals.dart';
import '../newJournal.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dots_indicator/dots_indicator.dart';

class CardCarousel extends StatefulWidget {
  double widthOfScreen;
  double heightOfScreen;

  CardCarousel(width, height) {
    widthOfScreen = width;
    heightOfScreen = height;
  }

  @override
  _CardCarousel createState() => _CardCarousel();
}

class _CardCarousel extends State<CardCarousel> {
  List<EmojiCanvasPreview> previewCanvases;
  int _currentPosition = 0;

  @override
  void initState() {
    print('init');

    /// replace this for-loop with API-call that returns all previous canvases.
    previewCanvases = [];
    /// IF THE AMOUNT OF CANVASES EXCEED ~ 29 THE BUBBLE INDICATOR WILL OVERFLOW
    for(int i=0; i<10; i++){
      previewCanvases.add(
        EmojiCanvasPreview(
          emojis: globalEmojiList1,
          color: Colors.blue[i*100],
          widthOfScreen: widget.widthOfScreen,
          heightOfScreen: widget.heightOfScreen,
        )
      );
    }
    /*EmojiCanvasPreview canvas1 = EmojiCanvasPreview(
      emojis: globalEmojiList1,
      color: Colors.amber,
      widthOfScreen: widget.widthOfScreen,
      heightOfScreen: widget.heightOfScreen,
    );
    EmojiCanvasPreview canvas2 = EmojiCanvasPreview(
      emojis: globalEmojiList1,
      color: Colors.blue,
      widthOfScreen: widget.widthOfScreen,
      heightOfScreen: widget.heightOfScreen,
    );
    EmojiCanvasPreview canvas3 = EmojiCanvasPreview(
      emojis: globalEmojiList1,
      color: Colors.green,
      widthOfScreen: widget.widthOfScreen,
      heightOfScreen: widget.heightOfScreen,
    );
    EmojiCanvasPreview canvas4 = EmojiCanvasPreview(
      emojis: globalEmojiList1,
      color: Colors.red[800],
      widthOfScreen: widget.widthOfScreen,
      heightOfScreen: widget.heightOfScreen,
    );
    EmojiCanvasPreview canvas5 = EmojiCanvasPreview(
      emojis: globalEmojiList1,
      color: Colors.purple,
      widthOfScreen: widget.widthOfScreen,
      heightOfScreen: widget.heightOfScreen,
    );
    EmojiCanvasPreview canvas6 = EmojiCanvasPreview(
      emojis: globalEmojiList1,
      color: Colors.black26,
      widthOfScreen: widget.widthOfScreen,
      heightOfScreen: widget.heightOfScreen,
    );

    previewCanvases.add(canvas1);
    previewCanvases.add(canvas2);
    previewCanvases.add(canvas3);
    previewCanvases.add(canvas4);
    previewCanvases.add(canvas5);
    previewCanvases.add(canvas6);*/
    //}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return Column(
      children: [
        (previewCanvases.length != 0)
            ? CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height *
                      widget.heightOfScreen,
                  //width:constraints.maxWidth,
                  aspectRatio: (MediaQuery.of(context).size.height *
                          widget.widthOfScreen) /
                      (MediaQuery.of(context).size.height *
                          widget.heightOfScreen),
                  autoPlay: false,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentPosition = index;
                    });
                  },
                ),
                items: previewCanvases.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        elevation: 8,
                        child: Container(
                            width: MediaQuery.of(context).size.width * widget.widthOfScreen,
                            height: MediaQuery.of(context).size.height *widget.heightOfScreen,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new NewJournal(
                                          oldCanvasEmojis: i.emojis,
                                          oldCanvasColor: i.color)),
                                );
                              },
                              child: Container(
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    i,
                                    Container(
                                      //decoration: BoxDecoration( border: Border.all(color: Colors.blue)),
                                      color: Colors.white38,
                                      width: MediaQuery.of(context).size.width * widget.widthOfScreen,
                                      height: MediaQuery.of(context).size.height *widget.heightOfScreen*0.35,
                                      child: ClipRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text("Golfing with Dad", 
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                            fontSize: 25,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                ),
                                                Text("Järn-nian är sne, råttinvasion. Huset brinner och pizzabudet tackade nej till dricks. Akta dogleg", 
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                            fontSize: 18,
                                                            //fontWeight: FontWeight.bold,
                                                          ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                              ),
                            )
                        ),
                      );
                    },
                  );
                }).toList(),
              )
            : Card(
                elevation: 8,
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.1),
                  width: MediaQuery.of(context).size.width * widget.widthOfScreen,
                  height: MediaQuery.of(context).size.height * widget.heightOfScreen,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'You do not have journaled any situations, create a new one below!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),

                    ),
                    ) ,
                    

                    //Image.asset("images/log.jpeg"), //Text('text $i', style: TextStyle(fontSize: 16.0),)
                ),
              ),
        (previewCanvases.length != 0)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: previewCanvases.map((i) {
                  int index = previewCanvases.indexOf(i);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPosition == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              )
            : Text(' '),
      ],
    );
  }
}
