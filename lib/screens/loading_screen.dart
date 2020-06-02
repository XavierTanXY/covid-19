import 'dart:convert';

import 'dart:async';
import 'dart:io';

import 'package:covid19app/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid19app/helper/constants.dart';
import 'package:covid19app/model/virus.dart';
import 'package:covid19app/helper/network_helper.dart';
import 'package:covid19app/main.dart';
import 'package:covid19app/helper/global_data.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'entry_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:covid19app/model/graph_data.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var futureRank = GlobalData.networkHelper.getWorldStatsByRank();
    futureRank.then((List<VirusData> value) {
      GlobalData.countryByRank = value;
    },onError: (e) {
      print(e);
    });

    var future = GlobalData.networkHelper.getWorldStats();

      future.then((VirusData value) {

        var future2 = GlobalData.networkHelper.getGraphStats(kWorldWide);
        future2.then((GraphData graphData) {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return EntryScreen(virusData: value,graphData: graphData);
          }));

        },onError: (e) {
          print(e);
          Alert(context: context, title: "Unavailable", desc: "Data is not available.").show();
        });




    },onError: (e) {
      print(e);
    });

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitSquareCircle(
          color: kMainCOlor,
          size: 100.0,
        ),
      ),
    );
  }
}
