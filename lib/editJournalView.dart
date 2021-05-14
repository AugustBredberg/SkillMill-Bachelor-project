

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:skillmill_demo/objects/emojiCanvas.dart';
import 'package:skillmill_demo/objects/movableObject.dart';
import 'package:flutter_emoji_keyboard/flutter_emoji_keyboard.dart';
import 'objects/colorPicker.dart';
import 'objects/globals.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:icon_shadow/icon_shadow.dart';
import  'package:keyboard_actions/keyboard_actions.dart';

class EditJournalView extends StatefulWidget {
  List<EmojiMetadata> oldCanvasEmojis;
  Color oldCanvasColor;
  Function callback;

  EditJournalView(emojiList, color, callback) {
    this.oldCanvasEmojis = List.from(emojiList);
    this.oldCanvasColor = color;
    this.callback = callback;
  }
  
  
  @override
  _EditJournalView createState() => _EditJournalView();
}

class _EditJournalView extends State<EditJournalView> with SingleTickerProviderStateMixin{
  final TextEditingController controller = TextEditingController();
  PanelController normalKeyboardController;
  PanelController emojiKeyboardController;
  PanelController colorSliderController;
  EmojiCanvas impact;
  GlobalKey<EmojiCanvasState> _myEmojiCanvas;

  OverlayEntry overlayEntry;
  OverlayEntry backbuttonOverlay;

  List<EmojiMetadata> copyOfEmojisBeforeEditing;
  TextField textField; 
  FocusNode keyboardFocusNode;

  bool creatingNewText;

  AnimationController _controller;
  Animation _animation;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: this.keyboardFocusNode,
          onTapAction: () {
            print("CALLING ONtEXTdONE");
            onTextDone(controller.text);
            controller.text = '';
            //Navigator.of(context).pop();
            this.normalKeyboardController.close();
          },
        ),
      ],
    );
  }


  void setColorToChosen(Color color) {
      this._myEmojiCanvas.currentState.appendColor(color);
  }

  void _appendEmojiToImpactCanvas(MoveableStackItem item) {
      this._myEmojiCanvas.currentState.appendEmoji(item);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 300.0, end: 50.0).animate(_controller)
    ..addListener(() {
      setState(() {});
    });
    
    creatingNewText = false;
    this.keyboardFocusNode = FocusNode(); 
    keyboardFocusNode.addListener(() {
      if (keyboardFocusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    
    this.copyOfEmojisBeforeEditing = [];

    for(var emoji in widget.oldCanvasEmojis) {
      this.copyOfEmojisBeforeEditing.add(EmojiMetadata.clone(emoji));
    }
    normalKeyboardController = new PanelController();
    emojiKeyboardController = new PanelController();
    colorSliderController = new PanelController();
    _myEmojiCanvas = new GlobalKey<EmojiCanvasState>();

    List<MoveableStackItem> listOfItems = [];
    for (var i in widget.oldCanvasEmojis) {
      listOfItems.add(MoveableStackItem(i, new GlobalKey<MoveableStackItemState>()));
    }

    this.impact = EmojiCanvas(
        key: this._myEmojiCanvas,
        emojis: listOfItems,
        color: widget.oldCanvasColor);

    
  }

  @override
  void dispose() {
    _controller.dispose();
    this.keyboardFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height * editCanvasHeight);
    return WillPopScope(
      onWillPop: showBackbuttonOverlay,
      child: SlidingUpPanel(
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
        //// EMOJI KEYBOARD PANEL
        ///////////////////////////////
        backdropEnabled: true,
        backdropOpacity: 0,
        boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.transparent)],
        color: Colors.transparent,
        controller: this.emojiKeyboardController,
        minHeight: 1,
        maxHeight: MediaQuery.of(context).size.height*0.87, 
        panel: showEmojiKeyboard(context),
        body: SlidingUpPanel(
          ///////////////////////////////
          //// NORMAL KEYBOARD PANEL
          ///////////////////////////////
          isDraggable: false,
          backdropEnabled: true,
          backdropOpacity: 0,
          boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.transparent)],
          color: Colors.transparent,
          controller: this.normalKeyboardController,
          minHeight: 1,
          maxHeight: MediaQuery.of(context).size.height* 0.7, 
          panel: showNormalKeyboard(context),
          body:Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: Center(
              child: Stack(
                children: [
                  Material(
                    child: this.impact,
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
                              this.colorSliderController.open();   
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
                              this.emojiKeyboardController.open();                             
                            },
                          ),
                        ),
                        Material(
                          type: MaterialType.transparency,
                          child: IconButton(
                            iconSize: MediaQuery.of(context).size.width*0.15,
                            icon: IconShadowWidget(
                              Icon(Icons.keyboard, size: MediaQuery.of(context).size.width*0.15,),
                              shadowColor: Colors.white54,
                            ),
                            onPressed: () {
                              this.keyboardFocusNode.requestFocus();
                              normalKeyboardController.open();                           
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
                          widget.callback(this._myEmojiCanvas.currentState.currentMetaData, this._myEmojiCanvas.currentState.currentColors);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ),
                
              ],
            ),
          ),
          ),
        ),
      ),
      ),
    );
  }

  Material showNormalKeyboard(BuildContext context) {
    return Material(
      color: Colors.white54,
      child:  Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              //SizedBox(height: _animation.value),
               KeyboardActions(
              autoScroll: false,
              config: _buildConfig(context),
              child: TextField(
                style: TextStyle(fontSize: 20),
                controller: this.controller,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                maxLength: 50,
                focusNode: this.keyboardFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "",
                 
                ),
                onChanged: (input){
                  print("ändraddd " + input);
                  print(input.length);
                  int moden = input.length;
                  if(moden % 10 == 0){
                    print("MOD 10 ÄR TRUE ");
                  }
                }
              ),
            ),
            ],
          ),
        ),
    );
  }

  Container showEmojiKeyboard(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: IconButton(
                padding: EdgeInsets.all(0),
                iconSize: MediaQuery.of(context).size.height*0.05,
                icon: Icon(Icons.keyboard_arrow_down_sharp, size:MediaQuery.of(context).size.height*0.05 ),
                onPressed: (){ this.emojiKeyboardController.close(); },
              ),
            ), 
            Material(
              color: Color.fromRGBO(0, 0,0, 0.15),
              child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.80,
                  width: MediaQuery.of(context).size.width * 1,
                  child:  ClipRect(
                    child: new BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), 
                     
                      child: EmojiKeyboard(
                        column: 4,
                        color: Colors.transparent,
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
          color: Color.fromRGBO(0, 0, 0, 0.15),
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
  }

  Future<bool> showBackbuttonOverlay() async {
    print("showing overlay");
    OverlayState overlayState = Overlay.of(context);
    this.backbuttonOverlay = OverlayEntry(
      builder: (context) {
        return Material(
          color:Colors.transparent, 
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      widget.callback(copyOfEmojisBeforeEditing, widget.oldCanvasColor);
                      popBackbuttonOverlay(context);
                      Navigator.pop(context);
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
    this.emojiKeyboardController.close();
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

  void onTextDone(String text) {
    //popEditOverlay(context);
    //this..close();
    controller.text += text;
    print(text);
    MoveableStackItem item = MoveableStackItem(
        EmojiMetadata(text, [
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
