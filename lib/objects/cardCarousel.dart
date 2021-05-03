
import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skillmill_demo/objects/emojiCanvasPreview.dart';
import 'emojiCanvasPreview.dart';
import 'globals.dart';
import '../newJournal.dart';

class CardCarousel extends StatefulWidget{
  List<String> cardPictureAdresses;

  CardCarousel(cardPictureAdresses) {
    cardPictureAdresses = cardPictureAdresses;
  }

  @override
  _CardCarousel createState() => _CardCarousel();
}


class _CardCarousel extends State<CardCarousel>{
  //List<String> cardPics = [];
  String testUrl = "images/king.jpg";
  int _currentIndex;
  EmojiCanvasPreview a = EmojiCanvasPreview(emojis: globalEmojiList1, color: Colors.amber, widthOfScreen: 0.75, heightOfScreen: 0.75,);
  Image b = Image.asset('images/back.png');
  Image c = Image.asset('images/jack.png');
  Image d = Image.asset('images/joker.jpg');
  Image e = Image.asset('images/queen.png');
  //List<Image> lst = [a,a,a,a,a];
  List cardList;
 

  @override
  void initState() {
    print('init');
    _currentIndex = 0;
    super.initState();
    this.cardList=[a,b,c,d,e];
    //cardPics = widget.cardPictureAdresses;
  }
 

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return CarouselSlider(
        options: CarouselOptions(
          height:constraints.maxHeight,
          //width:constraints.maxWidth,
          aspectRatio: 1/1,
          autoPlay: false,
          enlargeCenterPage: true,
        ),
        items: [a,a,a,a,a].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: constraints.maxHeight*1.8,//MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.amber
                ),
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