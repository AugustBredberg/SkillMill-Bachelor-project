import 'package:flutter/material.dart';
import 'package:skillmill_demo/newJournal.dart';
import 'package:skillmill_demo/objects/API-communication.dart';
import 'package:skillmill_demo/objects/emojiCanvasPreview.dart';
import 'objects/cardCarousel.dart';
import 'objects/globals.dart' as globals;

class Home extends StatefulWidget {
  String name;

  Home(name) {
    this.name = name;
  }
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {


  Future<List<EmojiCanvasPreview>> getEmojiCanvases() async {
    Map allSituationIDs = await getAllSituations(globals.token);
    print(allSituationIDs);
    if(!allSituationIDs.values.elementAt(0)){
      print("Failed getting situation IDs");
      return Future.value(null);
    }
    List<EmojiCanvasPreview> listOfCanvases = [];
    for(int i=0; i < allSituationIDs.values.elementAt(1).length; i++){
      Map successGetCanvasColor = await getCanvasColor(globals.token, allSituationIDs.values.elementAt(1)[i]);
      Map successGetSituationInfo = await getSituationInfo(globals.token, allSituationIDs.values.elementAt(1)[i]);
      //Map successGetCanvasEmojis = null;

      if(successGetCanvasColor.values.elementAt(0) && successGetSituationInfo.values.elementAt(0)){
        EmojiCanvasPreview preview = EmojiCanvasPreview(
          title: successGetSituationInfo.values.elementAt(1), 
          emojis: [], 
          color: successGetCanvasColor.values.elementAt(1), 
          widthOfScreen: 0.7, 
          heightOfScreen: 0.7,
          ID:allSituationIDs.values.elementAt(1)[i],
        );
        listOfCanvases.add(preview);
      }
    }
    return listOfCanvases;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
                child: FutureBuilder(
                  builder: (context, data) {
                    if (data.connectionState == ConnectionState.none &&
                        data.hasData == null) {
                      //print('project snapshot data is: ${projectSnap.data}');
                      return Container();
                    }
                    print("recieved some kind of data");
                    print(data.data);
                    if(data.data == null){
                      print("");
                      return Container();//CardCarousel(null, 0.7, 0.7);
                    }
                    else{
                      print("creating cardcarousel with the canvses from API");
                      return CardCarousel(data.data, 0.7, 0.7);
                    }
                  },
                  future: getEmojiCanvases(),
                ),
                
                
                
                
                
                
              ),//JournalFeed()
            ),
          ],
      ),
    );
  }
}
