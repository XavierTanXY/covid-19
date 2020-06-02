import 'package:intl/intl.dart';

class VirusData {

  final String total_cases;
  final String total_deaths;
  final String total_recovered;
  final String new_cases;
  final String new_deaths;
  final Map<String,dynamic> data;

  final String country;

  final String recordedTime;

  final String serious_critical;

  VirusData({this.total_cases, this.total_deaths, this.total_recovered, this.new_cases, this.new_deaths, this.data, this.country, this.serious_critical, this.recordedTime});


  VirusData fromJson(Map<String, dynamic> json, String country) {

    Map<String,dynamic> temp = Map<String, dynamic>();

    temp['total_cases'] = json['total_cases'];
    temp['total_deaths'] = json['total_deaths'];
    temp['total_recovered'] = json['total_recovered'];
    temp['new_cases'] = '+${json['new_cases']}';
    temp['new_deaths'] = '+${json['new_deaths']}';

    if( json['statistic_taken_at'] != null ) {
      temp['recordedTime'] = new DateFormat('yyyy-MM-dd h:mma').format(DateTime.parse(json['statistic_taken_at']).toLocal());
    } else if( json['record_date'] != null ) {
      temp['recordedTime'] = new DateFormat('yyyy-MM-dd h:mma').format(DateTime.parse(json['record_date']).toLocal());

    }

    return VirusData(
      total_cases: json['total_cases'],
      total_deaths: json['total_deaths'],
      total_recovered: json['total_recovered'],
      new_cases: '+${json['new_cases']}',
      new_deaths: '+${json['new_deaths']}',
      data: temp,
      country: country,
      recordedTime: temp['recordedTime']
    );
  }


  VirusData fromJsonByRank(Map<String, dynamic> json, String country) {

    Map<String,dynamic> temp = Map<String, dynamic>();

    temp['total_cases'] = json['cases'];
    temp['total_deaths'] = json['deaths'];
    temp['total_recovered'] = json['total_recovered'];
    temp['new_cases'] = json['new_cases'];
    temp['new_deaths'] = json['new_deaths'];
    temp['new_deaths'] = json['serious_critical'];

    return VirusData(
        total_cases: json['cases'],
        total_deaths: json['deaths'],
        total_recovered: json['total_recovered'],
        new_cases: json['new_cases'],
        new_deaths: json['new_deaths'],
        serious_critical: json['serious_critical'],
        data: temp,
        country: country
    );
  }

}