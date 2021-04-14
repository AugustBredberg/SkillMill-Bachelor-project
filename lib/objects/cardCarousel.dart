
import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/carousel.dart';

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
//  cardPics.add("");
  Image a = Image.asset('images/king.jpg');
  Image b = Image.asset('images/back.png');
  Image c = Image.asset('images/jack.png');
  Image d = Image.asset('images/joker.jpg');
  Image e = Image.asset('images/queen.png');
  //List<Image> lst = [a,a,a,a,a];


  @override
  void initState() {
    print('init');
    super.initState();
    //cardPics = widget.cardPictureAdresses;
  }
 

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Carousel(
          height: MediaQuery.of(context).size.height * 0.40,
          width: MediaQuery.of(context).size.width * 0.40,
          initialPage: 0,
          showArrow: false,
          showIndicator: false,
          //indicatorType: IndicatorTypes.values,
          allowWrap: true,
          type: Types.slideSwiper,
          onCarouselTap: (i) {
            print("onTap $i");
          },
          axis: Axis.vertical,
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
        ),
      );
  }
}