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
import 'package:overlay_container/overlay_container.dart';

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
  final TextEditingController controller =
      TextEditingController(); // controller for the keyboard
  GlobalKey<EmojiCanvasState> _myEmojiCanvas;
  GlobalKey<EmojiCanvasPreviewState> _previewKey;

  EmojiCanvas impact;
  EmojiCanvasPreview preview;

  OverlayEntry overlayEntry;
  OverlayEntry backbuttonOverlay;

  PanelController keyboardController;
  PanelController colorSliderController;
  Material editOverlay;
  bool _showBackbuttonDialog = false;


  @override
  void initState() {
    //editOverlay = showColorSlider(context);
    keyboardController = new PanelController();
    colorSliderController = new PanelController();
   
    /// Completely empty canvas, ready to be filled with emojis
    _myEmojiCanvas = new GlobalKey<EmojiCanvasState>();
    _previewKey = new GlobalKey<EmojiCanvasPreviewState>();

    /// This list is for the editable canvas, it contians movable stack items.
    /// 
    
    List<MoveableStackItem> listOfItems = [];
    for (var i in widget.oldCanvasEmojis) {
      listOfItems.add(MoveableStackItem(i, new GlobalKey<MoveableStackItemState>()));
    }

    this.impact = EmojiCanvas(
        key: this._myEmojiCanvas,
        emojis: listOfItems,
        color: widget.oldCanvasColor);

    //initiateEditCanvasEmojis(widget.oldCanvasEmojis);
    this.preview = EmojiCanvasPreview(
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



  
  void setColorToChosen(Color color) {
    //setState(() {
      this._myEmojiCanvas.currentState.appendColor(color);
    //});
  }

  void _appendEmojiToImpactCanvas(MoveableStackItem item) {
    //setState(() {
      this._myEmojiCanvas.currentState.appendEmoji(item);
    //});
  }

  Future<bool> onDiscardAllChanges() async { 
/*
    setState(() {
      print("calling setCanvasToPreviousState");
      List<MoveableStackItem> listofItems = [];
      for(var metadata in this._previewKey.currentState.currentMetadata){
        MoveableStackItem item = MoveableStackItem(metadata, new GlobalKey<MoveableStackItemState>());
        listofItems.add(item);
      }
      this._myEmojiCanvas.currentState.setCanvasToPreviousState(listofItems,_previewKey.currentState.currentColors);
      
      //this._myEmojiCanvas.currentState.currentColors = Colors.red;
      //this._myEmojiCanvas.currentState.currentEmojis = List.from(this.emojisBeforeEdit);
      //initiateEditCanvasEmojis(_myEmojiCanvas.currentState.currentMetaData);
      //this.impact.color = this.colorBeforeEdit;
    });*/
    //this._myEmojiCanvas.currentState.updateEmojis(this._previewKey.currentState.currentMetadata);
    this._previewKey.currentState.setState(() {
          
        });
        setState(() {
                  
                });
    popBackbuttonOverlay(context);
    popOverLay(context);

    return Future.value(false);
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
                          popOverLay(context);
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
                    Stack(alignment: Alignment.center, children: [
                      Container(
                      //alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: this.preview,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                      ),
                      IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          //this._myEmojiCanvas.currentState.dispose();
                          

                          showOverlay(context);
                        },
                      ),
                    ]),
                    Container(
                      height: 50.0,
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: Text('Save Entry'),
                          onPressed: () {
                            if (_myEmojiCanvas.currentState != null) {
                              print("changed globalrmojilist1");
                              globalEmojiList1 =
                              _myEmojiCanvas.currentState.currentMetaData;
                            }
                            //setState(() {
                              //this.keyboardController.close();  
                                                          
                              //                          });
                            
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

  showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    this.overlayEntry = OverlayEntry(
      builder: (context) => editCanvas(overlayState),
    );
    overlayState.insert(overlayEntry);
  }

  popOverLay(BuildContext context) {
    this.overlayEntry.remove();
  }

  Widget editCanvas(OverlayState state) {
    //OverlayState overlayState =state;
    //BuildContext contextYES = overlayState.context;
    //editOverlay = showColorSlider(context)
    print(MediaQuery.of(context).size.height * editCanvasHeight);
    //print(MediaQuery.of(context).size.width * editCanvasHeight);
    List<MoveableStackItem> listOfItems = [];
    for (var i in List.from(this.preview.emojis)) {
      //this.preview.
      listOfItems.add(MoveableStackItem(i, new GlobalKey<MoveableStackItemState>()));
    }
    //this.impact.emojis = listOfItems;
    this._myEmojiCanvas = GlobalKey<EmojiCanvasState>();
    return SlidingUpPanel(
      ///////////////////////////////
      //// COLOR-SLIDER PANEL
      ///////////////////////////////
      backdropEnabled: true,
      backdropOpacity: 0,
      boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.transparent)],
      color: Colors.transparent,
      controller: this.colorSliderController,
      minHeight: 1,
      maxHeight: MediaQuery.of(context).size.height*0.42,
      panel: showColorSlider(context),
      body: SlidingUpPanel(
        ///////////////////////////////
        //// KEYBOARD PANEL
        ///////////////////////////////
        backdropEnabled: true,
        backdropOpacity: 0,
        boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.transparent)],//Color.fromRGBO(255, 255, 255, 0.1))],
        color: Colors.transparent,
        controller: this.keyboardController,
        minHeight: 1,
        maxHeight: MediaQuery.of(context).size.height*0.87, 
        panel: showKeyboard(context),//showKeyboard(context), 
        body:Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Center(
            child: Stack(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  child: EmojiCanvas(key: this._myEmojiCanvas, emojis: listOfItems, color: this.preview.color ),
                  //this.impact,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  child: Material(
                    color:Colors.transparent,
                    child: IconButton(
                      iconSize: MediaQuery.of(context).size.width*0.15,
                      onPressed:  (){
                        print("pressing toggle");
                        showBackbuttonOverlay();
                        //_toggleBackbuttonDialog();
                        print(_showBackbuttonDialog);
                       
                         },

                        icon: IconShadowWidget(
                        Icon(Icons.arrow_back_rounded, 
                          color: Colors.black, 
                          size: MediaQuery.of(context).size.width*0.15,
                        ),
                        shadowColor: Colors.white54,
                      ),
                    ),
                  ),
                ),


                Positioned(
                  top: 50,
                  right: 0,
                  child: Column(
                    children: [
                      Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          iconSize: MediaQuery.of(context).size.width*0.15,
                          icon: IconShadowWidget(
                            Icon(
                              Icons.color_lens,
                              size: MediaQuery.of(context).size.width*0.15,
                            ),
                            shadowColor: Colors.white54,
                          ),
                          onPressed: () {
                            //setState(() {
                              this.colorSliderController.open();                             
                            //});
                          },
                        ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          iconSize: MediaQuery.of(context).size.width*0.15,
                          icon: IconShadowWidget(
                            Icon(Icons.emoji_emotions, size: MediaQuery.of(context).size.width*0.15,),
                            shadowColor: Colors.white54,
                          ),
                          onPressed: () {
                            //setState(() {
                              this.keyboardController.open();                             
                            //});
                          },
                        ),
                      ),
                      
                    ],
                ),
              ),
              Positioned(
                bottom:30,
                right:30,
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    iconSize: MediaQuery.of(context).size.width*0.15,
                    padding: EdgeInsets.all(0),
                    color: Colors.green,
                    icon: IconShadowWidget(
                            Icon(
                              Icons.done_sharp,
                              size: MediaQuery.of(context).size.width*0.15,
                              color: Colors.black,
                            ),
                            shadowColor: Colors.white54, 
                    ),
                    onPressed: () {
                      setState(() {
                        print("DONE");
                        /// Updates the preview canvas to the edited canvas
                        this._previewKey.currentState.updateEmojis(this._myEmojiCanvas.currentState.currentMetaData);
                        this._previewKey.currentState.updateColor(this._myEmojiCanvas.currentState.currentColors);
                        /// Makes sure that the edit-canvas actually updates
                        this.impact.emojis = this._myEmojiCanvas.currentState.currentEmojis;
                        this.impact.color =  this._myEmojiCanvas.currentState.currentColors;
                        
                        print("SETTING EMOJISBEFOREEDIT");
                      });
                      popOverLay(context);
                    },
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

  Container showKeyboard(BuildContext context) {
    
    return Container(
        //padding: const EdgeInsets.only(top:60.0),
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: IconButton(
                padding: EdgeInsets.all(0),
                iconSize: MediaQuery.of(context).size.height*0.05,
                icon: Icon(Icons.keyboard_arrow_down_sharp, size:MediaQuery.of(context).size.height*0.05 ),
                onPressed: (){ this.keyboardController.close(); },
              ),
            ), 
            Material(
              color: Color.fromRGBO(0, 0,0, 0.15),//Colors.transparent,
              child: Container(
                   
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.80,
                  width: MediaQuery.of(context).size.width * 1,
                  child:  ClipRect(
                    child: new BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), //.blur(sigmaX: 10.0, sigmaY: 10.0),
                     
                      child: EmojiKeyboard(
                        column: 4,
                        color: Colors.transparent,//fromRGBO(255, 255, 255, 0.5),
                        floatingHeader: false,
                        height: MediaQuery.of(context).size.height * 0.9,
                        onEmojiSelected: onEmojiSelected,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
    );
  }

  Column showColorSlider(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: IconButton(
            padding: EdgeInsets.all(0),
            iconSize: MediaQuery.of(context).size.height*0.05,
            icon: Icon(Icons.keyboard_arrow_down_sharp, size:MediaQuery.of(context).size.height*0.05 ),
            onPressed: (){ this.colorSliderController.close(); },
          ),
        ), 
        Material(
          color: Color.fromRGBO(0, 0, 0, 0.15),//Colors.transparent,
          child: Container(
            alignment: Alignment.topCenter,
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 1,
            child: ClipRect(
              child: BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), 
                child: ColorPicker(MediaQuery.of(context).size.width * 0.6,setColorToChosen)
                
              ),
            ),
          ),
        ),
      ],
    );

    //overlayState.insert(overlayEdit);
  }

  Future<bool> showBackbuttonOverlay() async {
    if(this.overlayEntry != null){
      if(!this.overlayEntry.mounted){
        return Future.value(true);
      }
    }
    else{
      return Future.value(true);
    }
   
    
    OverlayState overlayState = Overlay.of(context);
    this.backbuttonOverlay = OverlayEntry(
      builder: (context) {
        return Material(
          color:Color.fromRGBO(0, 0, 0, 0.3),
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
                      onDiscardAllChanges();
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
    return Future.value(false);
    
  }

  popBackbuttonOverlay(BuildContext context) {
    this.backbuttonOverlay.remove();
  }

  void onEmojiSelected(Emoji emoji) {
    //popEditOverlay(context);
    this.keyboardController.close();
    controller.text += emoji.text;
    print(emoji.text);
    MoveableStackItem item = MoveableStackItem(
        EmojiMetadata(emoji.text, [
          0.4360759627327983,
          -0.00499969555783915,
          0.0,
          0.0,
          0.00499969555783915,
          0.4360759627327983,
          0.0,
          0.0,
          0.0,
          0.0,
          1.0,
          0.0,
          100.90648195061966,
          193.65734906587528,
          0.0,
          1.0
        ]),
        new GlobalKey<MoveableStackItemState>());
    _appendEmojiToImpactCanvas(item);
  }
}
