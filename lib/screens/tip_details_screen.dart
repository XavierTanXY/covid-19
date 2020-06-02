import 'package:covid19app/helper/constants.dart';
import 'package:flutter/material.dart';

class TipDetailScreen extends StatelessWidget {

  final String imgUrl;
  final String heroTag;
  final String title;
  final String detail;

  final IconData iconData;

  TipDetailScreen({this.imgUrl, this.heroTag, this.title, this.detail, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
         ),
        title: Text(''),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: heroTag,
                    child: Container(
                        height: 120,
                        width: 120,
                        child: imgUrl == '' ? Icon(iconData,
                        size: 120,
                        color: kMainCOlor,) : Image.asset(imgUrl)
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30
                  ),),
                  SizedBox(height: 10,),
                  Text(detail,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16
                    ),),
                ],
              )
          ),
        ),
      ),
    );
  }
}
