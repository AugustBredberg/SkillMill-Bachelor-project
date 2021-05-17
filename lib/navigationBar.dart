


import 'package:flutter/material.dart';
import 'package:skillmill_demo/home.dart';
import 'package:skillmill_demo/skillPage.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
        color: Colors.yellow,
        child: WillPopScope(
          onWillPop: () async => false,
          child: DefaultTabController(
            length: 3,
            child: new Scaffold(
              body: Home("haj"),
              /*
              
              
              TabBarView(
                children: [
                  TabContent(new Home("haj")),
                  TabContent(
                    Center(
                      child: Container(
                        color: Colors.white,
                        child: Text("SKILL PAGE"),
                      ),
                    )
                  ),
                  TabContent(
                    Center(
                      child: Container(
                        color: Colors.white,
                        child: Text("SETTINGS"),
                      ),
                    )
                  ),
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
              */
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
