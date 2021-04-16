import 'package:flutter/material.dart';
import 'package:skillmill_demo/journalPost.dart';

class JournalNote extends StatefulWidget {
  JournalPost impact;

  JournalNote(JournalPost impact) {
    this.impact = impact;
  }
  @override
  _JournalNote createState() => _JournalNote();
}

class _JournalNote extends State<JournalNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("SkillMill")),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.width * 0.05)),
                child: Text(
                  "Situation context",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: (MediaQuery.of(context).size.width * 0.07),
                  ),
                ),
              ),
              Container(
                child: widget.impact,
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.width * 0.05),
                ),
                child: Text(
                  "Situation impact",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: (MediaQuery.of(context).size.width * 0.07),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text("Context emoji thingy"),
                ),
                //margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.width * 0.05)),
                child: TextField(
                  maxLength: 250,
                  maxLines: 5,
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
}
