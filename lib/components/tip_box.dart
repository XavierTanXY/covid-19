import 'package:covid19app/helper/constants.dart';
import 'package:flutter/material.dart';

class TipBox extends StatelessWidget {

  final String title;
  final String imgUrl;
  final Function onPressed;
  final String tag;

  TipBox({this.title,this.imgUrl, this.onPressed, this.tag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    height: 70,
                    width: 70,
                    child: Hero(tag:tag,
                        child: Image.asset(imgUrl,))),
                Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
