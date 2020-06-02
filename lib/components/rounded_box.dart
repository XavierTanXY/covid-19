import 'package:flutter/material.dart';
import 'package:covid19app/helper/date_helper.dart';

class RoundedBox extends StatefulWidget {
//  RoundedBox({@required this.day, this.date, this.callBackOnPress});
//
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;
  final String day;
  final String date;

  const RoundedBox({
    Key key,
    @required this.index,
    @required this.isSelected,
    @required this.onSelect,
    this.day,
    this.date
  })  : assert(index != null),
        assert(isSelected != null),
        assert(onSelect != null),
        super(key: key);

  @override
  _RoundedBoxState createState() => _RoundedBoxState();
}

class _RoundedBoxState extends State<RoundedBox> {
  Color activeColor = Colors.yellow;

  Color inActiveColor = Colors.lightBlueAccent;

  void test() {
    DateHelper().addWeeks();
  }

  @override
  Widget build(BuildContext context) {
    test();
    return GestureDetector(
      onTap: widget.onSelect,
      child: Container(
        height: 100,
        width: 95,
        child: Container(
          color: widget.isSelected
              ? activeColor
              : inActiveColor,
          padding: EdgeInsets.all(10.0),
          child: Column(
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
        ),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: null,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
              color: Colors.black,
              width: 4
          ),

        ),
      ),
    );
  }
}
//class RoundedBox extends StatefulWidget {
//  RoundedBox({@required this.day, this.date, this.callBackOnPress});
////
////  final Color colour;
////  final Widget cardChild;
//  Function callBackOnPress;
//  final String day;
//  final String date;
//
//  bool isSelected = false;
//
//  @override
//  _RoundedBoxState createState() => _RoundedBoxState();
//}
//
//class _RoundedBoxState extends State<RoundedBox> {
//  Color activeColor = Colors.yellow;
//
//  Color inActiveColor = Colors.lightBlueAccent;
//
//  void test() {
//    DateHelper().addWeeks();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    test();
//    return GestureDetector(
//      onTap: () {
//
//        widget.callBackOnPress();
//        setState(() {
//          if(widget.isSelected) {
//            widget.isSelected = false;
//          } else {
//            widget.isSelected = true;
//          }
//        });
//
//      },
//      child: Container(
//        height: 100,
//        width: 95,
//        child: Container(
//          color: widget.isSelected
//              ? activeColor
//              : inActiveColor,
//          padding: EdgeInsets.all(10.0),
//          child: Column(
//            children: <Widget>[
//              Text(widget.day,
//              style: TextStyle(
//                fontWeight: FontWeight.bold,
//                color: Colors.black,
//                fontSize: 30
//              ),),
//              SizedBox(height: 12,),
//              Text(widget.date,
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                fontWeight: FontWeight.normal,
//                color: Colors.black38,
//                fontSize: 18
//              ),),
//            ],
//          ),
//        ),
//        margin: EdgeInsets.all(15.0),
//        decoration: BoxDecoration(
//          color: null,
//          borderRadius: BorderRadius.circular(20.0),
//          border: Border.all(
//              color: Colors.black,
//              width: 4
//          ),
//
//        ),
//      ),
//    );
//  }
//}
