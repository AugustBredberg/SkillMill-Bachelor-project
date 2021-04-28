
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_keyboard/flutter_emoji_keyboard.dart';
import 'package:skillmill_demo/objects/movableObject.dart';
import 'emojiCanvas.dart';




class EmojiKeyboardClass extends StatelessWidget {
  final Function callback;

  EmojiKeyboardClass(this.callback); 

  final TextEditingController controller = TextEditingController();

  void onEmojiSelected(Emoji emoji) {
    controller.text += emoji.text;
    //ChosenEmoji.chosenEmoji = emoji.text;
    //EmojiCanvas.
    
    MoveableStackItem item = MoveableStackItem(
        EmojiMetadata(emoji.text,
        [0.6463089079186324, 0.13423912881164965, 0.0, 0.0,
        -0.13423912881164965,0.6463089079186324, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        58.29945312195869, 11.104368977904983, 0.0, 1.0]
        )
    );
    //_EmojiCanvas()._appendEmoji(item);
    //_appendEmojiToCanvas(item);
  }

  //void clearText() => controller.text = '';



  @override
  Widget build(BuildContext context) {

    

    return Container(
      color: Colors.black38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /*
          TextField(
            enableInteractiveSelection: false,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            maxLines: 4,
            controller: controller,
            style: TextStyle(
              fontSize: 28,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20.0),
            ),
          ),
          */
          /*
          FloatingActionButton(
            child: const Icon(Icons.clear),
            onPressed: clearText,
          ),
          */
          
          EmojiKeyboard(
            //categoryTitles: CategoryTitles(). ,
            floatingHeader: false,
            height: MediaQuery.of(context).size.height * 0.25,
            onEmojiSelected: onEmojiSelected,
          ),
        ],
      ),
    );
  }
}