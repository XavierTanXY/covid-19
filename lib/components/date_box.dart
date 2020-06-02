import 'package:flutter/material.dart';
import 'package:covid19app/helper/global_data.dart';
class DateBox extends StatefulWidget {

//  final int index;
//  final bool isSelected;
//  final VoidCallback onSelect;
  final String day;
  final String date;

  DateBox({this.day,
    this.date
  });

  @override
  _DateBoxState createState() => _DateBoxState();
}

class _DateBoxState extends State<DateBox> {
  Color activeColor = Colors.yellow;

  Color inActiveColor = Colors.lightBlueAccent;

  void test() {

    GlobalData.dateHelper.addWeeks();
//    DateHelper().addWeeks();
  }

  @override
  Widget build(BuildContext context) {
    test();
    return Container(
//        color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.day,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30
            ),),
          SizedBox(height: 10,),
          Text(widget.date,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black38,
                fontSize: 18
            ),),
        ],
      ),
    );
  }
}
