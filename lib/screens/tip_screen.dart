import 'package:covid19app/components/tip_box.dart';
import 'package:covid19app/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:covid19app/screens/tip_details_screen.dart';
import 'package:flutter/services.dart';



class TipScreen extends StatefulWidget {

  @override
  _TipScreenState createState() => _TipScreenState();
}

class _TipScreenState extends State<TipScreen> {
  List<String> titleArray = ['How it spreads?', 'How to protect yourself?', 'Avoid close contacts', 'Take steps to protect yourself', 'Clean & Disinfect'];

  List<String> detailArray = ['The virus is thought to spread mainly from person-to-person contact through respiratory droplets produced when an infected person coughs or sneezes.', 'Frequently Wash your hands with soap and water for at least 20 seconds. Always Carry a hand sanitizer that contains at least 60% alcohol. Avoid touching your eyes, nose, and mouth with unwashed hands.', 'Avoid close contact with people who are sick. Put distance between yourself and other people if COVID-19/Coronavirus is spreading in your community.', 'Cover your mouth and nose with a tissue when you cough or sneeze or use the inside of your elbow. Immediately wash your hands with soap and water for at least 20 seconds or clean your hands with a hand sanitizer that contains at least 60% alcohol.', 'Clean & disinfect frequently touched surfaces daily. This includes tables, doorknobs, light switches, countertops, handles, desks, phones, keyboards, toilets, faucets, and sinks. If surfaces are dirty, clean them: Use detergent or soap and water prior to disinfection.'];
  List<String> imgUrlArray = ['assets/spread.png', 'assets/wash.png', 'assets/home.png', 'assets/mask.png', 'assets/clean.png'];

  List<String> tagArray = ['1', '2', '3', '4', '5'];


  List<TipBox> getTipBoxes() {

    List<TipBox> boxes = [];
    for( int i = 0; i < titleArray.length; i++) {
      boxes.add(TipBox(
        title: titleArray[i],
        imgUrl: imgUrlArray[i],
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TipDetailScreen(imgUrl: imgUrlArray[i], heroTag: tagArray[i],detail: detailArray[i],title: titleArray[i],iconData: null,);
          }));
        },
        tag: tagArray[i],
      ));
    }

    return boxes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainCOlor,
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text('Tips',
        style: TextStyle(
          color: kMainCOlor
        ),),
      ),
      body: Container(
        child: GridView.count(
            crossAxisCount: 2,
          padding: EdgeInsets.all(8),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: getTipBoxes()
        )
      ),
    );
  }
}
