import 'package:flutter/material.dart';
import 'tabBar/FirstTab.dart';
import 'tabBar/secTab.dart';
import 'tabBar/thirdTab.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('NetClock'),
          centerTitle: true,
          backgroundColor: Colors.red[600],
          bottom: TabBar(
            indicatorColor: Colors.black87,
            tabs: [
              Tab(
                text: 'Timer',
              ),
              Tab(
                text: 'Stopwatch',
              ),
              Tab(
                text: 'Date/Time',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
            FirstTab(),
            SecTab(),
            ThirdTab(),
        ],
        ),
      ),
    );
  }
}
