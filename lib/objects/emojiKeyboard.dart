
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_keyboard/flutter_emoji_keyboard.dart';
import 'package:skillmill_demo/journalPost.dart';

import 'package:skillmill_demo/objects/movableObject.dart';


class EmojiKeyboardClass extends StatelessWidget {
  final Function callback;

  EmojiKeyboardClass(this.callback); 

  final TextEditingController controller = TextEditingController();

  void onEmojiSelected(Emoji emoji) {
    controller.text += emoji.text;
    ChosenEmoji.chosenEmoji = emoji.text; 
    ChosenEmoji.movableEmojis.add(
      MoveableStackItem(
        Text('${ChosenEmoji.chosenEmoji}', style: TextStyle(fontSize: 200),)
      )
    );
    print(ChosenEmoji.chosenEmoji);
    //ChosenEmoji();
    callback();
  }

  //void clearText() => controller.text = '';



  @override
  Widget build(BuildContext context) {

    

    return  Container(
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
            floatingHeader: false,
            height: MediaQuery.of(context).size.height * 0.25,
            onEmojiSelected: onEmojiSelected,
          ),
        ],
      ),
    );
  }
}