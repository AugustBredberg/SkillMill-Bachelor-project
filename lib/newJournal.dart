import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillmill_demo/objects/emojiCanvas.dart';
import 'package:skillmill_demo/objects/emojiCanvasPreview.dart';
import 'package:skillmill_demo/objects/movableObject.dart';
import 'package:flutter_emoji_keyboard/flutter_emoji_keyboard.dart';
import 'objects/colorPicker.dart';
import 'objects/movableObject.dart';
import 'objects/globals.dart';

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

  OverlayState overlayState;
  OverlayEntry overlayEntry;
  OverlayEntry overlayEdit;

  @override
  void initState() {
    overlayState = Overlay.of(context);

    /// Completely empty canvas, ready to be filled with emojis
    _myEmojiCanvas = new GlobalKey<EmojiCanvasState>();
    _previewKey = new GlobalKey<EmojiCanvasPreviewState>();

    /// This list is for the editable canvas, it contians movable stack items.
    List<MoveableStackItem> listOfItems = [];
    for (var i in widget.oldCanvasEmojis) {
      listOfItems
          .add(MoveableStackItem(i, new GlobalKey<MoveableStackItemState>()));
    }

    this.impact = EmojiCanvas(
        key: this._myEmojiCanvas,
        emojis: listOfItems,
        color: widget.oldCanvasColor);
    this.preview = EmojiCanvasPreview(
        key: this._previewKey,
        emojis: widget.oldCanvasEmojis,
        color: widget.oldCanvasColor,
        widthOfScreen: 0.6,
        heightOfScreen: 0.6);
    super.initState();
  }

  void setColorToChosen(Color color) {
    setState(() {
      this._myEmojiCanvas.currentState.appendColor(color);
    });
  }

  void _appendEmojiToImpactCanvas(MoveableStackItem item) {
    setState(() {
      this._myEmojiCanvas.currentState.appendEmoji(item);
    });
  }

  Future<bool> onBackPressed() async { //rewrite
    if (overlayEdit != null && overlayEdit.mounted) {
      //Keyboard active
      print("other overlay already up, popping that overlay");
      popEditOverlay(context);
      return Future.value(false);
    } else if (overlayEntry != null && overlayEntry.mounted) {
      //No Keyboard active
      popOverLay(context);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("60% of width: " +
        (MediaQuery.of(context).size.width * 0.6).toString());
    print("60% of height: " +
        (MediaQuery.of(context).size.height * 0.6).toString());
    return WillPopScope(
      onWillPop: onBackPressed,
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
                        popEditOverlay(context);
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
      builder: (context) => editCanvas(),
    );
    overlayState.insert(overlayEntry);
  }

  popOverLay(BuildContext context) {
    this.overlayEntry.remove();
  }

  Widget editCanvas() {
    print(MediaQuery.of(context).size.height * editCanvasHeight);
    print(MediaQuery.of(context).size.width * editCanvasHeight);
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      child: Center(
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              child: this.impact,
            ),
            Positioned(
              top: 50,
              right: 0,
              child: Column(
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: IconButton(
                      iconSize: 50,
                      icon: Icon(
                        Icons.color_lens,
                      ),
                      onPressed: () {
                        showColorSlider(context);
                      },
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: IconButton(
                      iconSize: 50,
                      icon: Icon(Icons.emoji_emotions),
                      onPressed: () {
                        showKeyboard(context);
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          print("DONE");

                          /// Updates the preview canvas to the edited canvas
                          this._previewKey.currentState.updateEmojis(
                              this._myEmojiCanvas.currentState.currentMetaData);
                          this._previewKey.currentState.updateColor(
                              this._myEmojiCanvas.currentState.currentColors);

                          /// Makes sure that the edit-canvas actually updates
                          this.impact.emojis =
                              this._myEmojiCanvas.currentState.currentEmojis;
                          this.impact.color =
                              this._myEmojiCanvas.currentState.currentColors;
                        });
                        popOverLay(context);
                      },
                      child: Text("Done")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showKeyboard(BuildContext context) {
    if (overlayEdit != null && overlayEdit.mounted) {
      //hejhå
      print("other overlay already up, popping that overlay");
      popEditOverlay(context);
    }
    //OverlayState overlayState = Overlay.of(context);
    this.overlayEdit = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.width * 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                IconButton(
                  iconSize: MediaQuery.of(context).size.height * 0.05,
                  icon: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    popEditOverlay(context);
                    print("popped keyboard");
                  },
                ),
                EmojiKeyboard(
                  column: 4,
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                  floatingHeader: false,
                  height: MediaQuery.of(context).size.height * 0.875,
                  onEmojiSelected: onEmojiSelected,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEdit);
  }

  showColorSlider(BuildContext context) {
    if (overlayEdit != null && overlayEdit.mounted) {
      print("other overlay already up, popping that overlay");
      popEditOverlay(context);
    }
    this.overlayEdit = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.width * 0,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              popEditOverlay(context);
              print("clicketyy");
            },
            child: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ColorPicker(MediaQuery.of(context).size.width * 0.6,setColorToChosen))),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEdit);
  }

  popEditOverlay(BuildContext context) {
    this.overlayEdit.remove();
  }

  void onEmojiSelected(Emoji emoji) {
    popEditOverlay(context);
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
          0,//100.90648195061966,
          -50,//193.65734906587528,
          0.0,
          1.0
        ]),
        new GlobalKey<MoveableStackItemState>());
    _appendEmojiToImpactCanvas(item);
  }
}
