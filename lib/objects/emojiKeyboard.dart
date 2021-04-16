
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_keyboard/flutter_emoji_keyboard.dart';
import 'package:skillmill_demo/journalPost.dart';

import 'package:skillmill_demo/objects/movableObject.dart';

class EmojiMetadata{
  String emoji;
  List<double> matrixArguments;
  
  
  
  
  List<double> column0;
  List<double> column1;
  List<double> column2;
  List<double> column3;

  EmojiMetadata(String emoji, List<double> args){
    this.emoji = emoji;
    this.matrixArguments = args;
  }
}



class EmojiKeyboardClass extends StatelessWidget {
  final Function callback;

  EmojiKeyboardClass(this.callback); 

  final TextEditingController controller = TextEditingController();

  void onEmojiSelected(Emoji emoji) {
    controller.text += emoji.text;
    //ChosenEmoji.chosenEmoji = emoji.text; 
    EmojisOnStack.movableEmojis.add(
      MoveableStackItem(
        
        EmojiMetadata(emoji.text,
        [0.6463089079186324, 0.13423912881164965, 0.0, 0.0,
        -0.13423912881164965,0.6463089079186324, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        58.29945312195869, 11.104368977904983, 0.0, 1.0]
        )
      )
    );
    print(emoji.text);
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