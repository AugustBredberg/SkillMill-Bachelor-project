
import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skillmill_demo/objects/emojiCanvas.dart';
import 'package:skillmill_demo/objects/emojiCanvasPreview.dart';
import 'emojiCanvasPreview.dart';
import 'globals.dart';
import '../newJournal.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardCarousel extends StatefulWidget{
  double widthOfScreen;
  double heightOfScreen;

  CardCarousel(width, height) {
    widthOfScreen = width;
    heightOfScreen = height;
  }

  @override
  _CardCarousel createState() => _CardCarousel();
}


class _CardCarousel extends State<CardCarousel>{
  //List<String> cardPics = [];
  String testUrl = "images/king.jpg";
  int _currentIndex;
  List<EmojiCanvasPreview> previewCanvases;

  //List<Image> lst = [a,a,a,a,a];
  List cardList;
 

  @override
  void initState() {
    print('init');
    /// replace this for-loop with API-call that returns all previous canvases.
    previewCanvases = [];
    for(int i=0; i<5; i++){
      EmojiCanvasPreview canvas = EmojiCanvasPreview(emojis: globalEmojiList1, color: Colors.amber, widthOfScreen: widget.widthOfScreen, heightOfScreen: widget.heightOfScreen,);
      previewCanvases.add(canvas);
    }


    //previewCanvases = EmojiCanvasPreview(emojis: globalEmojiList1, color: Colors.amber, widthOfScreen: widget.widthOfScreen, heightOfScreen: widget.heightOfScreen,);
    _currentIndex = 0;
    super.initState();
    //cardPics = widget.cardPictureAdresses;
  }
 

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * widget.heightOfScreen,
          //width:constraints.maxWidth,
          aspectRatio: (MediaQuery.of(context).size.height*widget.widthOfScreen)/(MediaQuery.of(context).size.height * widget.heightOfScreen),
          autoPlay: false,
          enlargeCenterPage: false,
        ),
        items: previewCanvases.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Card(
                elevation: 8,
                child: Container(
                  //width: constraints.maxHeight*1.8,//MediaQuery.of(context).size.width,
                  //margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  new NewJournal(oldCanvasEmojis: i.emojis, oldCanvasColor: i.color)),
                        );
                      },
                      child: i,
                    )
                  
                  //Image.asset("images/log.jpeg"), //Text('text $i', style: TextStyle(fontSize: 16.0),)
                ),
              );
            },
          );
        }).toList(),
      );
      /*Carousel(
          height: constraints.maxHeight,//MediaQuery.of(context).size.height * 0.50,
          width: constraints.maxWidth,//MediaQuery.of(context).size.width * 0.50,
          initialPage: 0,
          //showArrow: true,
          showIndicator: true,
          indicatorType: IndicatorTypes.bar,
          indicatorBackgroundOpacity: 0,
          activeIndicatorColor: Colors.red,
          allowWrap: true,
          type: Types.slideSwiper,
          onCarouselTap: (i) {
            print("onTap $i");
          },
          onPageChange: (){},
          axis: Axis.horizontal,
          children:[
            Card(
              elevation: 10,
              child: a
            ),
            Card(
              elevation: 10,
              child: b
            ),
            Card(
              elevation: 10,
              child: c
            ),
            Card(
              elevation: 10,
              child: d
            ),
            Card(
              elevation: 10,
              child: e
            ),


          ] 
        
      );
      */
    }
  
      );
  }
}