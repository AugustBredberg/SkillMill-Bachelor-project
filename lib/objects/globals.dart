library my_prj.globals;

import 'package:flutter/material.dart';
import 'package:skillmill_demo/editJournalView.dart';
import 'emojiCanvas.dart';
import 'movableObject.dart';
/*
 👨
 🐀
 🏌🏻‍♂️
 🏑
⛳
😰

*/



List<EmojiMetadata> globalEmojiList1 = [
EmojiMetadata("👨", [0.4360759627327983, -0.00499969555783915, 0.0, 0.0, 0.00499969555783915, 0.4360759627327983, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, -14.845471174380336, 41.53820844087528, 0.0, 1.0]
, new GlobalKey<MoveableStackItemState>()),
EmojiMetadata("🐀", [0.47250309953448694, 0.1489420155059868, 0.0, 0.0, -0.1489420155059868, 0.47250309953448694, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 71.75985052274241, 241.04168173779937, 0.0, 1.0]
,new GlobalKey<MoveableStackItemState>()),
EmojiMetadata("🏌🏻‍♂️", [0.6012473616557651, -0.09284856901789418, 0.0, 0.0, 0.09284856901789418, 0.6012473616557651, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 52.7728145556063, -41.93076497377139, 0.0, 1.0]
, new GlobalKey<MoveableStackItemState>()),
EmojiMetadata("🏑", [0.7044037251824482, 0.03358727301083109, 0.0, 0.0, -0.03358727301083109, 0.7044037251824482, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 103.97224865891599, 254.65457237852303, 0.0, 1.0]
, new GlobalKey<MoveableStackItemState>()),
EmojiMetadata("⛳", [0.46493627259155534, -0.14322027500842627, 0.0, 0.0, 0.14322027500842627, 0.46493627259155534, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, -1.5605767041633278, 204.78621150633742, 0.0, 1.0]
, new GlobalKey<MoveableStackItemState>()),
EmojiMetadata("😰", [0.5350404093681398, 0.14954366183520787, 0.0, 0.0, -0.14954366183520787, 0.5350404093681398, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 253.71843690150598, 99.40581913816477, 0.0, 1.0]
, new GlobalKey<MoveableStackItemState>()),
];

double editCanvasWidth = 1;
double editCanvasHeight = 1;
bool isLoggedIn = false;
 const Color themeColor = Colors.green;//Color(0xff71af6c);

String token;

GlobalKey<EditJournalViewState> editStateKey;
