import 'package:flutter/material.dart';
import 'package:skillmill_demo/journalPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillmill_demo/objects/emojiCanvas.dart';
//import 'package:skillmill_demo/objects/emojiKeyboard.dart';
import 'package:skillmill_demo/objects/movableObject.dart';
import 'objects/cardCarousel.dart';
import 'package:flutter_emoji_keyboard/flutter_emoji_keyboard.dart';
import 'objects/colorPicker.dart';
//import 'package:emoji_picker/emoji_picker.dart';

class NewJournal extends StatefulWidget {
  NewJournal() {}
  @override
  _NewJournal createState() => _NewJournal();
}

class _NewJournal extends State<NewJournal> {
  final TextEditingController controller = TextEditingController(); // controller for the keyboard
  GlobalKey<EmojiCanvasState> _myEmojiCanvas;
  GlobalKey<EmojiCanvasState> _editKey;
  //GlobalKey<EmojiCanvasState> _myEmojiCanvasPreview;

  EmojiCanvas impact;
  //EmojiCanvas impactPreview;
  OverlayEntry overlayEntry;
  OverlayEntry overlayKeyboard;
  OverlayEntry overlayColorSlider;

  List imageAdresses = [
    "assets/images/log.jpeg",
    "assets/images/jack.png",
    "assets/images/back.png",
    "assets/images/joker.jpg",
    "assets/images/king.jpg",
    "assets/images/queen.png"
  ];

  @override
  void initState() {
    /// Completely empty canvas, ready to be filled with emojis
    _myEmojiCanvas = new GlobalKey<EmojiCanvasState>();
    _editKey = new GlobalKey<EmojiCanvasState>();
    //_myEmojiCanvasPreview = new GlobalKey<EmojiCanvasState>();
    this.impact        = EmojiCanvas(key: this._myEmojiCanvas, emojis: [], color: Colors.white); //([], []);
    //impactPreview = EmojiCanvas(key: _myEmojiCanvasPreview, emojis: [], color: Colors.blue);
    super.initState();
  }

  void setColorToChosen(Color color){
    //this._myEmojiCanvas.currentState.currentColors = color;
    this._myEmojiCanvas.currentState.appendColor(color);
    this._editKey.currentState.appendColor(color);
    //this._myEmojiCanvas.currentState.setState(() {
          
      //  });
    /*
    setState(() {
      _myEmojiCanvas.currentState.setState(() {});
      _editKey.currentState.setState(() {});
    });
    */
  }

  void _appendEmojiToImpactCanvas(MoveableStackItem item) {
    //this.impact._appendEmoji(item);
    this._myEmojiCanvas.currentState.appendEmoji(item);
    this._editKey.currentState.appendEmoji(item);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
          
        });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ElevatedButton(
              child: Text("Back"),
              onPressed: () {
                if (this.overlayEntry != null) {
                  if (!this.overlayEntry.mounted) {
                    Navigator.pop(context);
                    return;
                  } else {
                    popOverLay(context);
                  }
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            Center(child: Text("Situation Name")),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.width * 0.05)),
                child: TextField(
                  maxLength: 20,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter situation name",
                  ),
                ),
              ),
              Container(
                child: Center(
                    child: Stack(
                  children: [
                    GestureDetector(
                      onPanUpdate: (d){},
                      //// DOES NOTHING, ONLY PREVENTS EMOJIS FROM BEING MOVABLE
                      /// FUNKAR INTE, TESTA MED MED MAKEPREVIEWCANVAS???? PROBLEM MED DUPLICATE GLOBALKEY JUST NU
                      child: impact,//_myEmojiCanvas.currentState ==null ? EmojiCanvas(emojis: [] ,color: Colors.white) : EmojiCanvas(emojis: _myEmojiCanvas.currentState.currentEmojis ,color: _myEmojiCanvas.currentState.currentColors),
                      
                      //makePreviewCanvas(),
                      //impact
                      ),
                    //this.impactPreview,
                    IconButton(
                      icon: Icon(
                        Icons.edit//IconData(icon:Icons.edit, fontFamily: 'MaterialIcons'),
                      ),
                      onPressed: () {
                        showOverlay(context);
                        //showAsBottomSheet();
                      },
                    ),
                  ],
                )),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.width * 0.3,
                child: CardCarousel(imageAdresses),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                //height:0.2,
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.width * 0.05)),
                child: TextField(
                  maxLength: 250,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Write a short note about your entry",
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Save Entry"),
              )
            ],
          ),
        ),
      ),
    );
  }

  showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    this.overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.width * 0.000000001,
        child: createJournalPost(context),

        //JournalPost(),
      ),
    );
    overlayState.insert(overlayEntry);
  }

  popOverLay(BuildContext context) {
    //OverlayState overlayState = Overlay.of(context);
    this.overlayEntry.remove();
  }

  Widget createJournalPost(BuildContext context) { 
    
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.87,
      width: MediaQuery.of(context).size.width * 1.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              child: Container(
                height: MediaQuery.of(context).size.width * 0.95,
                width: MediaQuery.of(context).size.width * 0.95,
                child: EmojiCanvas(key: _editKey, emojis: _myEmojiCanvas.currentState.currentEmojis ,color: _myEmojiCanvas.currentState.currentColors),//impact,
              ),
            ),
            
            Row(
              children: [
                Material(
                  color: Colors.white,
                  child: IconButton(
                    iconSize: 50,
                    icon: Icon(Icons.keyboard),//Icon(IconData(0xe7eb, fontFamily: 'MaterialIcons')),
                    onPressed: () {
                      showKeyboard(context);
                    },
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: IconButton(
                    iconSize: 50,
                    icon: Icon(
                      Icons.color_lens,
                    ),
                    onPressed: () {
                      print("haj");
                      showColorSlider(context);
                      //print("hajdå");
                    },
                  ),
                ),
              ],
            ),

            ElevatedButton(
                onPressed: () {
                  
                  setState(() {
                    print("DONEDONEDONE");
                    this._myEmojiCanvas.currentState.setState(() {});
                    /*
                    this._myEmojiCanvasPreview.currentState.setState(() {
                      this._myEmojiCanvasPreview.currentState.currentEmojis = List.from(this._myEmojiCanvas.currentState.currentEmojis);
                      this._myEmojiCanvasPreview.currentState.currentColors = this._myEmojiCanvas.currentState.currentColors;
                    });
                    */
                  });
                  popOverLay(context);
                },
                child: Text("Done")),
          ],
        ),
      ),
    );
  }

  showKeyboard(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    this.overlayKeyboard = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.width * 0,
        child: Material(
            color: Colors.white,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.37,
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                children: [
                    IconButton(
                      iconSize: MediaQuery.of(context).size.height * 0.05,
                      icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        popKeyboard(context);
                        print("poppade keyboard");
                      },
                    ),
                  
                  /*
                  Container(
                    child: EmojiPicker(
                      rows: 3,
                      columns: 7,
                      buttonMode: ButtonMode.MATERIAL,
                      recommendKeywords: ["racing", "dog"],
                      numRecommended: 10,
                      onEmojiSelected: (emoji, category) {
                        
                        onEmojiSelected(emoji.emoji);
                      },
                    ),
                  ),
                  */
                  
                  EmojiKeyboard(
                    //categoryTitles: CategoryTitles(). ,
                    floatingHeader: false,
                    height: MediaQuery.of(context).size.height * 0.29,
                    onEmojiSelected: onEmojiSelected,
                  ),
                  
                  //EmojiKeyboardClass(null),
                ],
              ),
            )),

        //JournalPost(),
        //Text("haj")
      ),
    );
    overlayState.insert(overlayKeyboard);
  }

  showColorSlider(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    this.overlayKeyboard = OverlayEntry(
      builder: (context) => Positioned(
          bottom: MediaQuery.of(context).size.width * 0,
          child: Material(
            child: Column(
              children: [
                IconButton(
                    iconSize: 50,
                    icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    onPressed: () {
                      popColorSlider(context);
                      print("poppade keyboard");
                    },
                  ),
                
                Material(
                  color: Colors.white,
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.37,
                      width: MediaQuery.of(context).size.width * 1,
                      child: ColorPicker(MediaQuery.of(context).size.width * 0.5, setColorToChosen)
                  ),
                ),
              ],
            ),
          )
          //JournalPost(),
          //Text("haj")
          ),
    );

    overlayState.insert(overlayKeyboard);
  }

  popKeyboard(BuildContext context) {
    //OverlayState overlayState = Overlay.of(context);
    this.overlayKeyboard.remove();
  }

  popColorSlider(BuildContext context) {
    //OverlayState overlayState = Overlay.of(context);
    this.overlayKeyboard.remove();
  }


  void onEmojiSelected(Emoji emoji) {
    controller.text += emoji.text;
    MoveableStackItem item = MoveableStackItem(EmojiMetadata(emoji.text, [
      0.6463089079186324,
      0.13423912881164965,
      0.0,
      0.0,
      -0.13423912881164965,
      0.6463089079186324,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
      58.29945312195869,
      11.104368977904983,
      0.0,
      1.0
    ]));
    _appendEmojiToImpactCanvas(item);
  }
  
}
