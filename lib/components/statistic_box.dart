import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class StatisticBox extends StatelessWidget {

  final String imgUrl;
  final String title;
  final String stats;
  final List<double> data;
  final Color graphColor;
  final Color textColor;

  Container getGraph() {

    if( title == 'New Cases' || title == 'New Deaths') {
      return Container();
    } else {
      return Container(
        height: 80,
        child: new Sparkline(
            data: data,
          lineWidth: 3,
          lineColor: graphColor,
        ),
      );
    }
  }

  double getHeight() {

    if( title == 'New Cases' || title == 'New Deaths') {
      return 80.0;
    } else {
      return 180.0;
    }
  }

  double getBoxHeight() {

    if( title == 'New Cases' || title == 'New Deaths') {
      return 0.0;
    } else {
      return 20.0;
    }
  }

  StatisticBox({@required this.imgUrl, this.title, this.stats, this.data, this.graphColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(),
      child: Padding(
        padding: const EdgeInsets.only(top:0.0,bottom: 0.0),
        child: Card(
          elevation: 8.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(imgUrl,
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(width: 15),
                        Text(title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25
                          ),)
                      ],
                    ),
                    Text(stats,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                        color: textColor
                      ),)
                  ],
                ),
                SizedBox(
                  height: getBoxHeight(),
                ),
                getGraph()
              ],
            )
          ),
        ),
      ),
    );
  }
}
