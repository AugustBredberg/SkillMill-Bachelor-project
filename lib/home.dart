


import 'package:flutter/material.dart';
import 'package:skillmill_demo/journalFeed.dart';
import 'package:skillmill_demo/journalView.dart';
import 'package:skillmill_demo/skillPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
        color: Colors.yellow,
        child: WillPopScope(
          onWillPop: () async => false,
          child: DefaultTabController(
            length: 3,
            child: new Scaffold(
              body: TabBarView(
                children: [
                  TabContent(new JournalView("haj")),
                  TabContent(new SkillPage()),
                  TabContent(new SkillPage()),
                ],
              ),
              bottomNavigationBar: new TabBar(
                tabs: [
                  Tab(
                    icon: Container(child: Text("HOME"),)
                  ),
                  Tab(
                    icon: Container(child: Text("SKILLS"),),
                  ),
                  Tab(
                    icon: Container(child: Text("SETTINGS"),),
                  ),
                ],
                labelColor: Colors.yellow,
                unselectedLabelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.redAccent,
              ),
              backgroundColor: Colors.black,
            ),
          ),
        ),
      );
}

class TabContent extends StatefulWidget {
  final Widget content;
  TabContent(this.content);

  @override
  _TabContentState createState() => _TabContentState();
}

class _TabContentState extends State<TabContent>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    print('init ${widget.content}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // print('build ${widget.content}');

    return widget.content;
  }

  @override
  bool get wantKeepAlive => false;
}
