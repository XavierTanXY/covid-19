import 'package:covid19app/helper/constants.dart';
import 'package:covid19app/helper/location_helper.dart';
import 'package:covid19app/helper/network_helper.dart';
import 'package:covid19app/helper/date_helper.dart';
import 'package:covid19app/model/date.dart';
import 'package:covid19app/model/virus.dart';

class GlobalData {
  //this is what I need to have in many parts of my app
  static NetworkHelper networkHelper = NetworkHelper();
  static DateHelper dateHelper = new DateHelper();
  static LocationHelper locationHelper = new LocationHelper();


  static String selectedCountryName = kWorldWide;
  static String selectedCountryFlagUrl = kWorldWideFlagUrl;
  static DateModel selectedDate = dateHelper.getTodayDate();

  static List<VirusData> countryByRank;
}