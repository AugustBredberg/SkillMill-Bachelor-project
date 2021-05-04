import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillmill_demo/objects/emojiCanvas.dart';
import 'package:skillmill_demo/objects/emojiCanvasPreview.dart';
import 'package:skillmill_demo/objects/movableObject.dart';
import 'objects/cardCarousel.dart';
import 'package:flutter_emoji_keyboard/flutter_emoji_keyboard.dart';
import 'objects/colorPicker.dart';
import 'objects/movableObject.dart';
import 'objects/globals.dart';



class NewJournal extends StatefulWidget {
  List<EmojiMetadata> oldCanvasEmojis;
  Color oldCanvasColor;


  NewJournal({Key key, @required this.oldCanvasEmojis, @required this.oldCanvasColor}) : super(key: key);

  //NewJournal() {}
  @override
  _NewJournal createState() => _NewJournal();
}

class _NewJournal extends State<NewJournal> {
  final TextEditingController controller = TextEditingController(); // controller for the keyboard
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
    for(var i in widget.oldCanvasEmojis){
      listOfItems.add( MoveableStackItem(i, new GlobalKey<MoveableStackItemState>()));
    }
    

    this.impact  = EmojiCanvas(key: this._myEmojiCanvas, emojis: listOfItems, color: widget.oldCanvasColor);
    this.preview = EmojiCanvasPreview(key: this._previewKey, emojis: widget.oldCanvasEmojis, color: widget.oldCanvasColor, widthOfScreen: 0.6, heightOfScreen: 0.6);
    super.initState();
  }

  void setColorToChosen(Color color){
    setState(() {
      this._myEmojiCanvas.currentState.appendColor(color);
    });
  }

  void _appendEmojiToImpactCanvas(MoveableStackItem item) {
    setState(() {
      this._myEmojiCanvas.currentState.appendEmoji(item);      
    });
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width * 0.6);
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
                    popEditOverlay(context);
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
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.6, 
                child: Center(
                    child: Stack(
                        clipBehavior: Clip.hardEdge,
                        fit: StackFit.expand,
                        children: [
                          ///// PREVIEW CANVAS WITH EMOJIS THAT CANNOT BE MOVED///
                          this.preview,
                          ////////////////////////////////////////////////////////
                        ///
                          IconButton(
                            iconSize: 40,
                            icon: Icon(
                              Icons.edit
                            ),
                            onPressed: () {
                              showOverlay(context);
                            },
                          ),
                        ],
                      ),
                    
                  ),
                
                
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
              ),
              /*

              Container(
                width: MediaQuery.of(context).size.width * 0.40,
                height: MediaQuery.of(context).size.width * 0.3,
                child: Center(child: Text("Reflection", style: TextStyle(fontSize: 30))), 
                //CardCarousel([]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
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
              ), */

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
      builder: (context) => editCanvas(),

    );
    overlayState.insert(overlayEntry);
  }

  popOverLay(BuildContext context) {
    this.overlayEntry.remove();
  }
  Widget editCanvas(){
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
                child:this.impact,
                
              
            ),
            /*

            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    color: Colors.white,
                    child: IconButton(
                      iconSize: 50,
                      icon: Icon(Icons.keyboard),
                      onPressed: () {
                        showKeyboard(context);
                      },
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.40),
                  Material(
                    color: Colors.white,
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
                ],
                
              ),
            ),
*/
            Positioned(
              top: 50,
              right:0,
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
                      icon: Icon(Icons.keyboard),
                      onPressed: () {
                        showKeyboard(context);
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        print("DONEDONEDONE");
                        /// Updates the preview canvas to the edited canvas
                        this._previewKey.currentState.updateEmojis(this._myEmojiCanvas.currentState.currentMetaData);
                        this._previewKey.currentState.updateColor(this._myEmojiCanvas.currentState.currentColors);

                        /// Makes sure that the edit-canvas actually updates
                        this.impact.emojis = this._myEmojiCanvas.currentState.currentEmojis;
                        this.impact.color  = this._myEmojiCanvas.currentState.currentColors;
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
    if(overlayEdit != null && overlayEdit.mounted){
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
    if(overlayEdit != null && overlayEdit.mounted){
      print("other overlay already up, popping that overlay");
      popEditOverlay(context);
    }
    this.overlayEdit = OverlayEntry(
      builder: (context) => Positioned(
          bottom: MediaQuery.of(context).size.width * 0,
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                IconButton(
                    iconSize: 50,
                    icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    onPressed: () {
                      popEditOverlay(context);
                      print("popped colorslider");
                    },
                  ),
                
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 1,
                  child: ColorPicker(MediaQuery.of(context).size.width * 0.6, setColorToChosen)
              
                ),
              ],
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
    MoveableStackItem item = MoveableStackItem(EmojiMetadata(emoji.text, [0.4360759627327983, -0.00499969555783915, 0.0, 0.0, 0.00499969555783915, 0.4360759627327983, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 100.90648195061966, 193.65734906587528, 0.0, 1.0]
    ),new GlobalKey<MoveableStackItemState>()
    );
    _appendEmojiToImpactCanvas(item);
  }
  
}








/*
class CreateJournalPost extends StatefulWidget{
  EmojiCanvas impact;

  CreateJournalPost(EmojiCanvas impact) {
    this.impact = impact;  
  }
  
  @override State<StatefulWidget> createState() { 
   return CreateJournalPostState(); 
  } 


}


class CreateJournalPostState extends State<CreateJournalPost>{



  @override
  Widget build(BuildContext context) {
    return 
  }

}*/