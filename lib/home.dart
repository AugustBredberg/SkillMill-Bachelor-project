import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skillmill_demo/newJournal.dart';
import 'package:skillmill_demo/objects/API-communication.dart';
import 'package:skillmill_demo/objects/emojiCanvasPreview.dart';
import 'objects/cardCarousel.dart';
import 'objects/globals.dart' as globals;
import 'loginView.dart';
import 'services/storage.dart';
import 'package:spring_button/spring_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Home extends StatefulWidget {
  String name;

  Home(name) {
    this.name = name;
  }
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with TickerProviderStateMixin {
  AnimationController rotationController;

  Future<List<EmojiCanvasPreview>> getEmojiCanvases() async {
    Map allSituationIDs = await getAllSituations(globals.token);
    print(allSituationIDs);
    if (!allSituationIDs.values.elementAt(0)) {
      print("Failed getting situation IDs");
      return Future.value(null);
    }
    List<EmojiCanvasPreview> listOfCanvases = [];
    for (int i = 0; i < allSituationIDs.values.elementAt(1).length; i++) {
      Map successGetCanvasColor = await getCanvasColor(
          globals.token, allSituationIDs.values.elementAt(1)[i]);
      Map successGetSituationInfo = await getSituationInfo(
          globals.token, allSituationIDs.values.elementAt(1)[i]);
      Map successGetCanvasEmojis = await getEmojiData(
          globals.token, allSituationIDs.values.elementAt(1)[i]);

      if (successGetCanvasColor.values.elementAt(0) &&
          successGetSituationInfo.values.elementAt(0) &&
          successGetCanvasEmojis.values.elementAt(0)) {
        EmojiCanvasPreview preview = EmojiCanvasPreview(
          title: successGetSituationInfo.values.elementAt(1) != null
              ? successGetSituationInfo.values.elementAt(1)
              : "",
          emojis: successGetCanvasEmojis.values.elementAt(1),
          color: successGetCanvasColor.values.elementAt(1),
          widthOfScreen: 0.7,
          heightOfScreen: 0.7,
          ID: allSituationIDs.values.elementAt(1)[i],
        );
        listOfCanvases.add(preview);
      }
    }
    return listOfCanvases;
  }

  Future<List<Text>> getTextPrompts() async {
    Map successGetPrompts = await randomPrompts();
    List<Text> textWidgetList = [];
    if (successGetPrompts.values.elementAt(0)) {
      List promptList = successGetPrompts.values.elementAt(1);
      for (int i = 0; i < promptList.length; i++) {
        textWidgetList.add(Text(
          promptList[i].toString(),
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ));
      }
    }
    return textWidgetList;
  }

  Future<Map> getHomeInformation() async {
    List<EmojiCanvasPreview> canvases;
    List<Text> prompts;

    canvases = await getEmojiCanvases();
    prompts = await getTextPrompts();
    print(prompts);
    Map homeInfo = {canvases: canvases, prompts: prompts};
    return homeInfo;
  }

  @override
  void initState() {
    // TODO: implement initState

    rotationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);

    //rotationController.addListener(() => setState(() {}));
    TickerFuture tickerFuture = rotationController.repeat();
    tickerFuture.timeout(Duration(seconds: 3 * 10), onTimeout: () {
      rotationController.forward(from: 0);
      rotationController.stop(canceled: true);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            alignment: Alignment.topRight,
            child: SpringButton(
              SpringButtonType.WithOpacity,
              Icon(
                Icons.logout,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              onTap: () async {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.NO_HEADER,
                    headerAnimationLoop: false,
                    animType: AnimType.TOPSLIDE,
                    btnOkText: "Yes",
                    //showCloseIcon: true,
                    //closeIcon: Icon(Icons.close_fullscreen_outlined),
                    title: 'Logout',
                    desc: 'Are you sure you want to logout?',
                    btnCancelOnPress: () {
                      return;
                    },
                    btnOkOnPress: () async {
                      bool success = await logout(globals.token);
                      if (success) {
                        globals.token = null;
                        removeToken();
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(pageBuilder: (BuildContext context,
                                Animation animation,
                                Animation secondaryAnimation) {
                              return LoginView();
                            }, transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return new SlideTransition(
                                position: new Tween<Offset>(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            }),
                            (Route route) => false);
                      }
                    })
                  ..show();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.10),
              child: FutureBuilder(
                builder: (context, data) {
                  if (data.connectionState == ConnectionState.none &&
                      data.hasData == null) {
                    //print('project snapshot data is: ${projectSnap.data}');
                    return Container();
                  }
                  print("recieved some kind of data");
                  print(data.data);

                  //rotationController.forward(from: 0.0);
                  //rotationController.repeat();

                  if (data.data == null) {
                    print("");
                    return Center(
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.50,
                        width: MediaQuery.of(context).size.width * 0.50,
                        //child: Image.asset('images/skillmill_logo_transparent.png'),

                        child: RotationTransition(
                          turns: Tween(begin: 0.0, end: 1.0)
                              .animate(rotationController),
                          child: Image.asset(
                              'images/skillmill_logo_transparent.png'),
                        ), // it starts the animation
                        /*CircularProgressIndicator(
                          strokeWidth: 8,
                          valueColor: new AlwaysStoppedAnimation<Color>(globals.themeColor),
                        ),*/
                      ),
                    ); //CardCarousel(null, 0.7, 0.7);
                  } else {
                    print("creating cardcarousel with the canvses from API");

                    Map homeInfo = data.data;
                    return CardCarousel(homeInfo.values.elementAt(0), 0.7, 0.7,
                        homeInfo.values.elementAt(1));
                  }
                },
                future: getHomeInformation(),
              ),
            ), //JournalFeed()
          ),
        ],
      ),
    );
  }
}
