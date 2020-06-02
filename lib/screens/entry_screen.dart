import 'package:covid19app/helper/constants.dart';
import 'package:covid19app/model/graph_data.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:covid19app/screens/home_screen.dart';
import 'package:covid19app/model/virus.dart';
import 'package:covid19app/screens/ranking_screen.dart';
import 'package:covid19app/screens/tip_screen.dart';
import 'package:covid19app/screens/setting_screen.dart';

class EntryScreen extends StatefulWidget {

  VirusData virusData;
  GraphData graphData;
  EntryScreen({this.virusData, this.graphData});

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {

  int currentIndex;
  List<Widget> _children;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _children = [
      HomeScreen(virusData: widget.virusData,graphData: widget.graphData,),
      RankingScreen(),
      TipScreen(),
      SettingScreen()
    ];
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
      print(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainCOlor,
      bottomNavigationBar: BubbleBottomBar(
      backgroundColor: Colors.white,
      opacity: .2,
      currentIndex: currentIndex,
      onTap: changePage,
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(
              20)),
      //border radius doesn't work when the notch is enabled.
      elevation: 10,
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
            backgroundColor: kMainCOlor,
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.home,
              color: kMainCOlor,
            ),
            title: Text("Dashboard")),
        BubbleBottomBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(
              Icons.show_chart,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.show_chart,
              color: Colors.deepPurple,
            ),
            title: Text("Ranking")),
        BubbleBottomBarItem(
            backgroundColor: Colors.indigo,
            icon: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: Colors.indigo,
            ),
            title: Text("Tips")),
        BubbleBottomBarItem(
            backgroundColor: Colors.green,
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            title: Text("Setting"))
      ],
    ),
      body: _children[currentIndex],
    );
  }
}
