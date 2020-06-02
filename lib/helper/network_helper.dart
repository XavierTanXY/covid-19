import 'dart:convert';

import 'dart:async';
import 'dart:io';

import 'package:covid19app/model/country.dart';
import 'package:covid19app/model/graph_data.dart';
import 'package:covid19app/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid19app/helper/constants.dart';
import 'package:covid19app/model/virus.dart';
import 'package:covid19app/helper/network_helper.dart';
import 'package:covid19app/model/graph_data.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';


class NetworkHelper {



  Future<GraphData> getGraphStats(String country) async {

    List<double> casesArray = [];
    List<double> deathsArray = [];
    List<double> recoverdArray = [];
    List<String> dateArray = [];


    final response = await http.get('https://pomber.github.io/covid19/timeseries.json');

    final responseJson = json.decode(response.body);

    int cases = 0;
    int death = 0;
    int recovered = 0;
    String date = '';


    if( country == kWorldWide ) {

      int tracker = 0;

      if( responseJson != null) {
        responseJson.forEach((k, v) {

//
//          int halfIdx = ((v.length / 2).round());
//          int idx = 0;

          for( int i = 0; i < v.length; i++ ) {

            cases = v[i]['confirmed'];
            death = v[i]['deaths'];
            recovered = v[i]['recovered'];

            if( tracker == 0 ) {
              casesArray.add(cases.toDouble());
//              print('index $i current total ${casesArray[i]} = ${casesArray[i]} + ${cases.toDouble()}');
              deathsArray.add(death.toDouble());
              recoverdArray.add(recovered.toDouble());
            } else {

              casesArray[i] = casesArray[i] + cases.toDouble();
//              print('index $i current total ${casesArray[i]} = ${casesArray[i]} + ${cases.toDouble()}');
              deathsArray[i] = deathsArray[i] + death.toDouble();
              recoverdArray[i] = recoverdArray[i] + recovered.toDouble();
            }

//            halfIdx++;
//            idx++;

          }

          tracker++;

        });

        return await GraphData(date: dateArray, cases: casesArray,deaths: deathsArray,recovered: recoverdArray);
      } else {
        return null;
      }
    } else {

      switch(country) {
        case 'USA':
          country = 'US';
          break;
        case 'UK':
          country = 'United Kingdom';
          break;
        case 'UAE':
          country = 'United Arab Emirates';
          break;
      }

      if( responseJson[country] != null ) {
          for( Map<String, dynamic> data in responseJson[country] ) {
            cases = data['confirmed'];
            death = data['deaths'];
            recovered = data['recovered'];
            date = data['date'];

            casesArray.add(cases.toDouble());
            deathsArray.add(death.toDouble());
            recoverdArray.add(recovered.toDouble());
            dateArray.add(date);
          }

          return await GraphData(date: dateArray, cases: casesArray,deaths: deathsArray,recovered: recoverdArray);

      } else {
        return null;
      }
    }
  }

  Future<VirusData> getLatestStatsByCountry(String country, String date) async {

    String todayDate = new DateFormat('yyyy-MM-dd').format(DateTime.now());

    String url = '';
    String key = '';

    if( todayDate == date ) {
      url = '$kBaseUrl/latest_stat_by_country.php?country=$country';
      key = 'latest_stat_by_country';

    } else {
      url = '$kBaseUrl/history_by_particular_country_by_date.php?country=$country&date=$date';
      key = 'stat_by_country';
    }

    print(url);

    final response = await http.get(
      url,
      headers: {kHeaderHost: kHostUrl, kHeaderApi: kAPIKey},
    );
    final responseJson = json.decode(response.body);

    return await VirusData().fromJson(responseJson[key][0], responseJson['country']);
  }

   Future<VirusData> getWorldStats() async {
    final response = await http.get(
      '$kBaseUrl/worldstat.php',
      headers: {kHeaderHost: kHostUrl, kHeaderApi: kAPIKey},
    );
    final responseJson = json.decode(response.body);

//    if( responseJson != null ) {
      return await VirusData().fromJson(responseJson, 'WorldWide');
//    } else {
//      return VirusData(total_cases: 'Not Available',total_deaths: 'Not Available',total_recovered: 'Not Available',new_cases: 'Not Available',new_deaths: 'Not Available',data: Map<String,dynamic>(), country: kWorldWide,serious_critical: 'Not Available');
//    }


  }

  Future<List<VirusData>> getWorldStatsByRank() async {

    List<VirusData> countryList = [];

    final response = await http.get(
      '$kBaseUrl/cases_by_country.php',
      headers: {kHeaderHost: kHostUrl, kHeaderApi: kAPIKey},
    );
    final responseJson = json.decode(response.body);

//    print(responseJson);
    var stats = responseJson['countries_stat'];

    for( var s in stats ) {
      countryList.add(VirusData().fromJsonByRank(s, s['country_name']));
    }
    return countryList;

  }

}