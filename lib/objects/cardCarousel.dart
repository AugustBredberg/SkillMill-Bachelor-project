import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skillmill_demo/objects/emojiCanvasPreview.dart';
import 'emojiCanvasPreview.dart';
import 'globals.dart';
import '../newJournal.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'emojiCanvas.dart';

class CardCarousel extends StatefulWidget {
  double widthOfScreen;
  double heightOfScreen;
  List<EmojiCanvasPreview> emojiCanvases;

  CardCarousel(givenCanvases, width, height) {
    print("in constructor of emojipreview: " + givenCanvases.toString());
    emojiCanvases = givenCanvases;
    widthOfScreen = width;
    heightOfScreen = height;
  }

  @override
  _CardCarousel createState() => _CardCarousel();
}

class _CardCarousel extends State<CardCarousel> {
  List<EmojiCanvasPreview> previewCanvases;
  int _currentPosition = 0;


  List<Widget> buildCarouselCanvases(){
    return previewCanvases.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(bottom:15.0),
            child: ClipPath(
              clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))
              ),
              child: Card(
                elevation: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width * widget.widthOfScreen,
                  height: MediaQuery.of(context).size.height *widget.heightOfScreen,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => new NewJournal(
                                oldCanvasEmojis: i.emojis,
                                oldCanvasColor: i.color,
                                oldCanvasTitle: i.title,
                                canvasID: i.ID)
                        ),
                      );
                    },
                    child: i,
                  )
                ),
              
              ),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  void initState() {
    print('init');

    /// replace this for-loop with API-call that returns all previous canvases.
    previewCanvases = [];
    print("WIDGET.EMOJICANVSES " + widget.emojiCanvases.toString());
    if(widget.emojiCanvases != null){
      previewCanvases = widget.emojiCanvases;
      
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> carouselCanvases = [];
    print("LENGTH: " + previewCanvases.length.toString());
    if(previewCanvases.length > 0){
      print("called buildCarouselCanses");
      carouselCanvases = buildCarouselCanvases();
    }

    if(carouselCanvases.length < 5){
      carouselCanvases.add(
        Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(bottom:15.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => new NewJournal(
                        oldCanvasEmojis: [],
                        oldCanvasColor: Colors.white,
                        oldCanvasTitle: "",
                        canvasID: null,)),
                  );
                }, //////////////////////////////////////////////////////////////////////////////////////////////
                ////// CLIPPERN TAR BORT SKUGGA OXÅ, AJA BAJA 
                /////////////////////////////////////////////////////////////////////////////////////////////////
                child: ClipPath(
                  clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    child:Container(
                      height: MediaQuery.of(context).size.height *widget.heightOfScreen,
                      width: MediaQuery.of(context).size.width * widget.widthOfScreen,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text("Add a new Situation", 
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ),
                          IconShadowWidget(
                          Icon(
                            Icons.add_circle_outline,
                            size: 80,
                          ),
                          shadowColor: Colors.grey[200],

                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        )
      );
    }
    
    return Column(
      children: [
        this._currentPosition > this.previewCanvases.length-1 ?
        Text('', 
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
        )
        :
        Text(this.previewCanvases[this._currentPosition].title, 
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
        ),
        Padding(
          padding: EdgeInsets.only(top:20),
        ),   
        CarouselSlider(
          options: CarouselOptions(
            enableInfiniteScroll: false,
            height: MediaQuery.of(context).size.height *
                (widget.heightOfScreen+0.02),
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
          items: carouselCanvases
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselCanvases.map((i) {
            int index = carouselCanvases.indexOf(i);
            return Container(
              width: _currentPosition == index ? 20 : 15.0,
              height: _currentPosition == index ? 20 : 15.0,
              margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index != carouselCanvases.length-1 
                    ? Color.fromRGBO(0, 0, 0, 1.9)
                    : previewCanvases.length == 5 ? Color.fromRGBO(0, 0, 0, 1.9) : Color.fromRGBO(0, 0, 0, 0.3),
              ),
            );
          }).toList(),
        ),
      ],
      
    );
  }
}
