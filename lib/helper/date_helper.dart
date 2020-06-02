import 'package:covid19app/model/date.dart';
import 'package:intl/intl.dart';

class DateHelper {


  List<DateModel> dates = [];


  DateHelper() {
    addWeeks();
  }

  void addWeeks() {

    for(int i = 0; i <= 10; i++) {
      DateTime pastTwoWeeks = DateTime.now().subtract(Duration(days: i));

      String day = new DateFormat('EEEE').format(pastTwoWeeks);
      String month = new DateFormat('MMMM').format(pastTwoWeeks);
      String date = new DateFormat('d').format(pastTwoWeeks);

      String id = new DateFormat('yyyy-MM-dd').format(pastTwoWeeks);

      dates.add(DateModel(id: id, date: date,month: month,day: day));
    }

  }

  DateModel getTodayDate() {
    return dates[0];
  }


}