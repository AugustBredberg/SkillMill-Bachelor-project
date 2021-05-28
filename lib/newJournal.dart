import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skillmill_demo/objects/emojiCanvas.dart';
import 'package:skillmill_demo/objects/emojiCanvasPreview.dart';
import 'package:skillmill_demo/objects/movableObject.dart';
import 'objects/movableObject.dart';
import 'objects/globals.dart' as globals;
import 'objects/API-communication.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'editJournalView.dart';
import 'package:spring_button/spring_button.dart';

class NewJournal extends StatefulWidget {
  List<EmojiMetadata> oldCanvasEmojis;
  Color oldCanvasColor;
  String oldCanvasTitle;
  int canvasID;

  NewJournal(
      {Key key,
      @required this.oldCanvasEmojis,
      @required this.oldCanvasColor,
      @required this.oldCanvasTitle,
      @required this.canvasID})
      : super(key: key);

  @override
  _NewJournal createState() => _NewJournal();
}

class _NewJournal extends State<NewJournal> {
  GlobalKey<EmojiCanvasPreviewState> _previewKey;
  TextEditingController titleController;

  EmojiCanvas impact;
  EmojiCanvasPreview preview;

  OverlayEntry overlayEntry;
  OverlayEntry backbuttonOverlay;

  Material editOverlay;
  bool titleDoesntExists = false;

  FocusNode focusNode = FocusNode();
  String hintTextTitle = 'Enter Title';

  @override
  void initState() {
    _previewKey = new GlobalKey<EmojiCanvasPreviewState>();
    titleController = TextEditingController();
    titleController.text = widget.oldCanvasTitle;
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintTextTitle = '';
      } else {
        hintTextTitle = 'Enter Title';
      }
      setState(() {});
    });
    List<MoveableStackItem> listOfItems = [];
    for (var i in widget.oldCanvasEmojis) {
      listOfItems
          .add(MoveableStackItem(i, new GlobalKey<MoveableStackItemState>()));
    }

    this.preview = EmojiCanvasPreview(
        title: "NewJournal",
        key: this._previewKey,
        emojis: List.from(widget.oldCanvasEmojis),
        color: widget.oldCanvasColor,
        widthOfScreen: 0.7,
        heightOfScreen: 0.7,
        ID: widget.canvasID);
    super.initState();
  }

  hintText() {}

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
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (this.focusNode.hasFocus) {
              this.focusNode.unfocus();
            }
          },
          child: Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(alignment: Alignment.center, children: [
                    Container(
                        height: MediaQuery.of(context).size.width * 0.25,
                        //color: Colors.red,
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                            top: (MediaQuery.of(context).size.width * 0.025)),
                        child: SpringButton(
                          SpringButtonType.WithOpacity,
                          Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.grey,
                            size: MediaQuery.of(context).size.width *
                                0.00018 *
                                MediaQuery.of(context).size.height,
                          ),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            showBackbuttonOverlay();
                          },
                        )), //child: Icon(Icons.arrow_back, color: Colors.red))),
                    Container(
                      //color: Colors.green,
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: MediaQuery.of(context).size.width * 0.70,
                      padding: EdgeInsets.only(
                          top: (MediaQuery.of(context).size.width * 0.05)),
                      child: TextField(
                        controller: titleController,
                        textAlign: TextAlign.center,
                        maxLength: 25,
                        focusNode: focusNode,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            alignLabelWithHint: true,
                            disabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: globals.themeColor, width: 0.5),
                            ),
                            border: InputBorder.none,
                            hintText: hintTextTitle,
                            errorText: titleDoesntExists
                                ? "Please enter a title"
                                : null),
                        onChanged: (change) {
                          this.titleDoesntExists = false;
                          print(titleController.text);
                        },
                      ),
                    ),
                  ]),
                  GestureDetector(
                    onTap: () {
                      globals.editStateKey = GlobalKey<EditJournalViewState>();
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => EditJournalView(
                                  key: globals.editStateKey,
                                  oldCanvasEmojis: this
                                      ._previewKey
                                      .currentState
                                      .currentMetadata,
                                  oldCanvasColor: this
                                      ._previewKey
                                      .currentState
                                      .currentColors,
                                  callback: (returnedEmojis, returnedColors) {
                                    setState(() {
                                      this
                                          ._previewKey
                                          .currentState
                                          .updateEmojis(returnedEmojis);
                                      this
                                          ._previewKey
                                          .currentState
                                          .currentColors = returnedColors;
                                    });
                                  })));
                      setState(() {});
                    },
                    child: Stack(alignment: Alignment.center, children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: ClipPath(
                          clipper: ShapeBorderClipper(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: this.preview,
                        ),
                      ),
                      Container(
                        //color: Colors.cyan,
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Material(
                            shape: CircleBorder(),
                            //width: MediaQuery.of(context).size.width * 0.2,
                            //height: MediaQuery.of(context).size.height* 0.1,
                            //decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.35),
                            //borderRadius: BorderRadius.all(Radius.circular(30),

                            //borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * MediaQuery.of(context).size.width*0.002),
                            child: Icon(
                              Icons.edit,
                              size: MediaQuery.of(context).size.height *
                                  MediaQuery.of(context).size.width *
                                  0.0002,
                            ) /*IconShadowWidget(Icon(Icons.edit, size: MediaQuery.of(context).size.height * MediaQuery.of(context).size.width*0.0002,), 
                        shadowColor: Colors.white54,
                        showShadow: false,),*/

                            ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.06,
                        right: MediaQuery.of(context).size.width * 0.1,
                        bottom: MediaQuery.of(context).size.height * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.canvasID == null
                            ? Text('')
                            : SpringButton(
                                SpringButtonType.WithOpacity,
                                Icon(Icons.delete_outlined,
                                    size: MediaQuery.of(context).size.width *
                                        0.15),
                                onTap: () async {
                                  /// PERMANENTLY REMOVE A CANVAS FROM THE DATABASE WITH API FUNCTIONS
                                  deleteSituation();
                                },
                              ),
                        SpringButton(
                          SpringButtonType.WithOpacity,
                          Icon(Icons.done_sharp,
                              size: MediaQuery.of(context).size.width * 0.15),
                          onTap: () async {
                            //DONE
                            ////////////////////////////////////////////////////////
                            /// UPLOAD CANVAS THROUGH API{}
                            ////////////////////////////////////////////////////////
                            Color currentColor = Colors.white;
                            if (this._previewKey.currentState != null) {
                              currentColor =
                                  this._previewKey.currentState.currentColors;
                            }
                            if (this.titleController.text == "") {
                              setState(() {
                                this.titleDoesntExists = true;
                              });
                              return;
                            }

                            try {
                              int situationID;
                              //// IF ID IS NULL, THEN THIS IS A NEW CANVAS AND WE HAVE TO CREATE IT WITH THE API
                              if (widget.canvasID == null) {
                                Map situation =
                                    await createSituation(globals.token);
                                if (!situation.values.elementAt(0)) {
                                  return;
                                }
                                situationID = situation.values.elementAt(1);
                              }

                              /// IF ID IS NOT NULL, THEN WE CAN GO AHEAD AND EDIT THE CANVAS
                              else {
                                situationID = widget.canvasID;
                              }
                              print(situationID);
                              bool successSetSituationInto =
                                  await setSituationInfo(
                                      globals.token,
                                      situationID,
                                      titleController.text,
                                      "Description");
                              print("TILTLE CONTROLLER TEXT: " +
                                  titleController.text);
                              bool successSetCanvasColor = await setCanvasColor(
                                  globals.token, situationID, currentColor);
                              bool successSetCanvasEmojis = await setEmojiData(
                                  globals.token,
                                  situationID,
                                  this
                                      ._previewKey
                                      .currentState
                                      .currentMetadata);
                              if (!successSetCanvasColor ||
                                  !successSetSituationInto ||
                                  !successSetCanvasEmojis) {
                                print(
                                    "FAILED TO SET INFO OR COLOR OR EMOJIS OF SITUATION");
                              }
                            } catch (exception) {
                              print(exception);
                              print("CAUGHT EXCEPTION IN SAVE JOURNAL");
                            }
                            HapticFeedback.vibrate();
                            AwesomeDialog(
                                context: context,
                                animType: AnimType.LEFTSLIDE,
                                headerAnimationLoop: false,
                                dialogType: DialogType.SUCCES,
                                title: 'Success',
                                desc: 'Successfully saved journal entry',
                                btnOkOnPress: () {
                                  debugPrint('');
                                },
                                btnOkIcon: Icons.check_circle,
                                onDissmissCallback: () {
                                  debugPrint('Dialog Dissmiss from callback');
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home');
                                })
                              ..show();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showBackbuttonOverlay() async {
    print("showing overlay");
    HapticFeedback.lightImpact();
    AwesomeDialog(
        context: this.context,
        dialogType: DialogType.WARNING,
        headerAnimationLoop: false,
        animType: AnimType.TOPSLIDE,
        btnOkText: "Yes",
        //showCloseIcon: true,
        //closeIcon: Icon(Icons.close_fullscreen_outlined),
        title: 'Abandon journal?',
        desc: 'Are you sure you want to abandon your journal?',
        btnCancelOnPress: () {
          return Future.value(false);
        },
        btnOkOnPress: () {
          Navigator.pop(this.context);
          return Future.value(true);
        })
      ..show();
    return Future.value(false);
  }

  deleteSituation() async {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.WARNING,
        title: 'Are you sure?',
        desc: 'This action will permanently delete the journal',
        btnOkText: "Yes",
        btnOkOnPress: () async {
          /////////////////////////////////////////////////////////////////////////
          //// DELETES THE SITUATION PERMANENTLY
          /////////////////////////////////////////////////////////////////////////
          bool successDeleteSituation =
              await removeSituation(globals.token, widget.canvasID);
          print(widget.canvasID.toString() + 'CANVAS ID');
          if (!successDeleteSituation) {
            print("DELETE SITUATION FAILED");
            return;
          }
          AwesomeDialog(
              context: context,
              animType: AnimType.LEFTSLIDE,
              headerAnimationLoop: false,
              dialogType: DialogType.INFO,
              title: 'Deleted',
              desc: 'Successfully deleted journal',
              btnOkOnPress: () {
                debugPrint('');
              },
              btnOkIcon: Icons.check_circle,
              onDissmissCallback: () {
                debugPrint('Dialog Dissmiss from callback');
                Navigator.of(context).pushReplacementNamed('/home');
              })
            ..show();
        },
        btnCancelText: "No",
        //btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {},
        btnCancelOnPress: () {
          return;
        })
      ..show();
  }
}
