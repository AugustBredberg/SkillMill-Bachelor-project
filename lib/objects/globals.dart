library my_prj.globals;

import 'package:flutter/material.dart';
import 'emojiCanvas.dart';

List<EmojiMetadata> globalEmojiList1 = [
  EmojiMetadata("😁", [
    0.5455864075592546,
    0.23959227626662247,
    0.0,
    0.0,
    -0.23959227626662247,
    0.5455864075592546,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    47.72492474056071,
    20.52010231174061,
    0.0,
    1.0
  ]),
  EmojiMetadata("😍", [
    0.556502151806804,
    -0.21308307599718299,
    0.0,
    0.0,
    0.21308307599718299,
    0.556502151806804,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    111.58206766329401,
    175.70538586541525,
    0.0,
    1.0
  ]),
];

double editCanvasWidth = 1;
double editCanvasHeight = 1;
bool isLoggedIn = false;
 const Color themeColor = Color(0xff71af6c);

String token;
