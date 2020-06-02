import 'package:covid19app/model/virus.dart';

class GraphData {

  final List<double> cases;
  final List<double> deaths;
  final List<double> recovered;
  final List<String> date;

  GraphData({this.date, this.cases,this.deaths, this.recovered});

}