
import 'package:flutter/material.dart';
import 'dart:async';
//import 'journalFeed.dart';

class JournalFeed extends StatefulWidget {

  @override
  _JournalFeed createState() => _JournalFeed();
}


class _JournalFeed extends State<JournalFeed>{
  Future<List<dynamic>> _activities;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
            future: null,
            builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (false) {
                return Center(child: CircularProgressIndicator());
              }
              print("BAABBABABBABA");
              return Container(
                margin: EdgeInsets.all(5),
                child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,

                  ),
                  itemBuilder: (context, index)  {
                    return Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset('images/log.jpeg',
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      //margin: EdgeInsets.all(),
                    );

                  },
                ),
              );
                  
            
            },
    );
  }
}