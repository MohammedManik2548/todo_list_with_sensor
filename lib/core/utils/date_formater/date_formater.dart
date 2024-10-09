import 'package:intl/intl.dart';

class DateFormater {
  static String dateFormatHyphen(String substring) {
    var finalDateToFormat = "";
    try {
      if (substring.isEmpty ||
          substring == '' ||
          substring == 'null' ||
          substring == 'Null' ||
          substring == '-' ||
          substring == 'NULL') {
        finalDateToFormat = '';
      } else {
        //dynamic updated
        // finalDateToFormat = DateFormat.yMMMd().format(DateTime.parse(substring));
        finalDateToFormat =
            DateFormat('EEE, dd MMM').format(DateTime.parse(substring));
      }

      return finalDateToFormat;
    } catch (e) {
      return substring;
    }
  }
}
