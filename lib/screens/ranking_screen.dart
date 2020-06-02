import 'package:covid19app/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:covid19app/helper/global_data.dart';
import 'package:covid19app/model/virus.dart';
import 'dart:async';



class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}



class _RankingScreenState extends State<RankingScreen> {

  List<VirusData> countryList;
  List<DataCell> nameCells = [];
  List<DataCell> casesCells = [];
  List<DataCell> deathsCells = [];

  List<Map<String, String>> dataCells = [];

  bool isAscendingCases = true;
  bool isAscendingDeath = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryList = GlobalData.countryByRank;
    setupCells();

  }

  void setupCells() {

    int limit = 100;
    int idx = 0;
    for( VirusData d in countryList) {

//      if( i/*dx == limit) {
//        break;
//      } else {*/
        dataCells.add({"name": d.country, "cases": d.total_cases, "deaths": d.total_deaths});
//      }

      idx++;
    }


    dataCells.sort((a,b) => (convertStrToInt('${b['cases']}').compareTo(convertStrToInt('${a['cases']}'))));
    dataCells.removeRange(99, dataCells.length-1);
    print(dataCells.length);
  }

  int convertStrToInt(String val) {
    return int.parse(val.replaceAll(",", ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking Top 100'),
        backgroundColor: kMainCOlor,
        elevation: 15,
      ),
      body: ListView(
        children: <Widget>[
          DataTable(
            sortAscending: isAscendingCases,
            columns: [
              DataColumn(label: Expanded(child: Text('Countries',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),)),onSort: (idx, sort){

                setState(() {
                  if( isAscendingCases ) {
                    dataCells.sort((a,b) => (a['name']).compareTo(b['name']));
                    isAscendingCases = false;
                  } else {
                    dataCells.sort((a,b) => (b['name']).compareTo(a['name']));
                    isAscendingCases = true;
                  }
                });


              }),
              DataColumn(label:
                Text('Total Cases'),
                numeric: true,
                onSort: (idx, sort) {
                setState(() {

                  if( isAscendingCases ) {
                    dataCells.sort((a,b) => (convertStrToInt('${a['cases']}').compareTo(convertStrToInt('${b['cases']}'))));
                    isAscendingCases = false;
                  } else {
                    dataCells.sort((a,b) => (convertStrToInt('${b['cases']}').compareTo(convertStrToInt('${a['cases']}'))));
                    isAscendingCases = true;
                  }
                });

                }
              ),
              DataColumn(label: Text('Total Deaths',overflow: TextOverflow.ellipsis,),
              numeric: true,
              onSort: (idx,sort) {

                setState(() {
                  if( isAscendingDeath ) {
                    dataCells.sort((a,b) => (convertStrToInt('${a['deaths']}').compareTo(convertStrToInt('${b['deaths']}'))));
                    isAscendingDeath = false;
                  } else {
                    dataCells.sort((a,b) => (convertStrToInt('${b['deaths']}').compareTo(convertStrToInt('${a['deaths']}'))));
                    isAscendingDeath = true;
                  }
                });

              }),
            ],
            rows: dataCells // Loops through dataColumnText, each iteration assigning the value to element
                .map(
              ((element) => DataRow(
                cells: <DataCell>[
                  DataCell(Container(width:75, child: Text(element["name"]))), //Extracting from Map element the value
                  DataCell(Container(width:50,child: Text(element["cases"]))),
                  DataCell(Container(width:50,child: Text(element["deaths"]))),
                ],
              )),
            ).toList(),
          )
        ],
      )

    );
  }
}
