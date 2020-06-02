import 'package:covid19app/helper/constants.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'screens/loading_screen.dart';
import 'package:covid19app/helper/global_data.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
    GlobalData.networkHelper.getGraphStats(kWorldWide);
  }
  void changePage(int index) {
    setState(() {
      currentIndex = index;
      print(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      extendBodyBehindAppBar: true,
//      appBar: AppBar(
////        backgroundColor: Colors.transparent,
//        backgroundColor: Color(0x44000000),
//        elevation: 0,
//        title: Text("Title"),
//      ),
//        bottomNavigationBar: BubbleBottomBar(
//          backgroundColor: Colors.white,
//          opacity: .2,
//          currentIndex: currentIndex,
//          onTap: changePage,
//          borderRadius: BorderRadius.vertical(
//              top: Radius.circular(
//                  20)),
//          //border radius doesn't work when the notch is enabled.
//          elevation: 10,
//          items: <BubbleBottomBarItem>[
//            BubbleBottomBarItem(
//                backgroundColor: Colors.red,
//                icon: Icon(
//                  Icons.dashboard,
//                  color: Colors.black,
//                ),
//                activeIcon: Icon(
//                  Icons.dashboard,
//                  color: Colors.red,
//                ),
//                title: Text("Home")),
//            BubbleBottomBarItem(
//                backgroundColor: Colors.deepPurple,
//                icon: Icon(
//                  Icons.access_time,
//                  color: Colors.black,
//                ),
//                activeIcon: Icon(
//                  Icons.access_time,
//                  color: Colors.deepPurple,
//                ),
//                title: Text("Logs")),
//            BubbleBottomBarItem(
//                backgroundColor: Colors.indigo,
//                icon: Icon(
//                  Icons.folder_open,
//                  color: Colors.black,
//                ),
//                activeIcon: Icon(
//                  Icons.folder_open,
//                  color: Colors.indigo,
//                ),
//                title: Text("Folders")),
//            BubbleBottomBarItem(
//                backgroundColor: Colors.green,
//                icon: Icon(
//                  Icons.menu,
//                  color: Colors.black,
//                ),
//                activeIcon: Icon(
//                  Icons.menu,
//                  color: Colors.green,
//                ),
//                title: Text("Menu"))
//          ],
//        ),
        body: LoadingScreen(),
    )
    );
  }
}
