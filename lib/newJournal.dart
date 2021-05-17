import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillmill_demo/objects/emojiCanvas.dart';
import 'package:skillmill_demo/objects/emojiCanvasPreview.dart';
import 'package:skillmill_demo/objects/movableObject.dart';
import 'package:flutter_emoji_keyboard/flutter_emoji_keyboard.dart';
import 'objects/colorPicker.dart';
import 'objects/movableObject.dart';
import 'objects/globals.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'editJournalView.dart';

class NewJournal extends StatefulWidget {
  List<EmojiMetadata> oldCanvasEmojis;
  Color oldCanvasColor;

  NewJournal(
      {Key key, @required this.oldCanvasEmojis, @required this.oldCanvasColor})
      : super(key: key);

  @override
  _NewJournal createState() => _NewJournal();
}

class _NewJournal extends State<NewJournal> {
  GlobalKey<EmojiCanvasPreviewState> _previewKey;

  EmojiCanvas impact;
  EmojiCanvasPreview preview;

  OverlayEntry overlayEntry;
  OverlayEntry backbuttonOverlay;

  Material editOverlay;


  @override
  void initState() {
   
    /// Completely empty canvas, ready to be filled with emojis
    _previewKey = new GlobalKey<EmojiCanvasPreviewState>();

    
    List<MoveableStackItem> listOfItems = [];
    for (var i in widget.oldCanvasEmojis) {
      listOfItems.add(MoveableStackItem(i, new GlobalKey<MoveableStackItemState>()));
    }

    //initiateEditCanvasEmojis(widget.oldCanvasEmojis);
    this.preview = EmojiCanvasPreview(
        title: "NewJournal",
        key: this._previewKey,
        emojis: List.from(widget.oldCanvasEmojis),
        color: widget.oldCanvasColor,
        widthOfScreen: 0.6,
        heightOfScreen: 0.6);
    ////////////////////////
    /// EDIT CANVAS REMEMBERS WHERE THE EMOJIS WERE AFTER PRESSING DISCARD CHANGES
    ////////////////////////
    super.initState();
  }


  

  @override
  Widget build(BuildContext context) {
    print("60% of width: " +
        (MediaQuery.of(context).size.width * 0.6).toString());
    print("60% of height: " +
        (MediaQuery.of(context).size.height * 0.6).toString());
    return WillPopScope(
      onWillPop: showBackbuttonOverlay,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                    Container(
                    height: MediaQuery.of(context).size.width * 0.25,
                    //color: Colors.red,
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: (){
                      if (this.overlayEntry != null) {
                        if (!this.overlayEntry.mounted) {
                          Navigator.pop(context);
                          return;
                        } 
                        else {
                          //popOverLay(context);
                          popBackbuttonOverlay(context);
                        }
                      } 
                      else {
                        Navigator.pop(context);
                      }
                      },
                    icon: Icon(Icons.arrow_back_rounded, color: Colors.grey, size: 40.0,),)),//child: Icon(Icons.arrow_back, color: Colors.red))),
                    Container(
                      //color: Colors.green,
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.width * 0.05)),
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLength: 25,
                          maxLines: 1,
                          style: TextStyle(fontSize: 25),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            alignLabelWithHint: true,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: "Enter title",
                          ),
                        ),
                    ),]),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditJournalView(
                                  this._previewKey.currentState.currentMetadata, this._previewKey.currentState.currentColors,
                                  (returnedEmojis, returnedColors){
                                    setState(() {
                                      this._previewKey.currentState.updateEmojis(returnedEmojis);
                                      this._previewKey.currentState.currentColors = returnedColors;
                                    });
                                  }
                                )
                              )
                            );
                            setState(() {});
                      },
                      child: Stack(alignment: Alignment.center, children: [
                        Container(
                        //alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: this.preview,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                       Icon(Icons.edit),
                      ]),
                    ),
                    Container(
                      height: 50.0,
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: Text('Save Entry'),
                          onPressed: () {
                            if (_previewKey.currentState != null) {
                              print("changed globalrmojilist1");
                              globalEmojiList1 = this.preview.emojis;//_previewKey.currentState.currentMetadata;
                            }
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.LEFTSLIDE,
                              headerAnimationLoop: false,
                              dialogType: DialogType.SUCCES,
                              title: 'Success',
                              desc:
                                  'Successfully saved journal entry',
                              btnOkOnPress: () {
                                debugPrint('');
                              },
                              btnOkIcon: Icons.check_circle,
                              onDissmissCallback: () {
                                debugPrint('Dialog Dissmiss from callback');
                                Navigator.of(context).pushReplacementNamed('/home');
                              }
                            )..show();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                            padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        
        ),
      );
  }



  Future<bool> showBackbuttonOverlay() async {
   
   print("showing overlay");
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      btnOkText: "Yes",
      //showCloseIcon: true,
      //closeIcon: Icon(Icons.close_fullscreen_outlined),
      title: 'Abandon journal?',
      desc:
          'Are you sure you want to abandon your journal?',
      btnCancelOnPress: () {
        return Future.value(false);
      },
      btnOkOnPress: () {
        Navigator.pop(context);
        return Future.value(true);
        
      })
    ..show();

    //return Future.value(false);
    /*
    OverlayState overlayState = Overlay.of(this.context);
    this.backbuttonOverlay = OverlayEntry(
      builder: (context) {
        return Material(
          color:Colors.transparent, //fromRGBO(0, 0, 0, 0.3),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.15)),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Center(
                      child: new Text("Are you sure you want to discard your changes?", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ),
                  

                  ElevatedButton(
                    child: Text('Abandon work'),
                    onPressed: () {
                      print("BACKBACKBACK");
                      //Navigator.pop(context);
                      return Future.value(true);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Cancel', style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      popBackbuttonOverlay(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                ],
              ),
            ),
        );
      }
    );
    overlayState.insert(backbuttonOverlay);
    return Future.value(false);*/
  }

  popBackbuttonOverlay(BuildContext context) {
    this.backbuttonOverlay.remove();
  }
}
