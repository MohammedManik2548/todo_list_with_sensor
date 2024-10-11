import 'package:intl/intl.dart';

class DateFormater {
  static DateTime stringToDate(String dateString) {
    // Adding the current year to the string

    // Define the format of the input string
    DateFormat format = DateFormat('EEE, d MMM');

    DateTime parsedDate = format.parse(dateString);

    print('String to convert Date: $parsedDate');
    return parsedDate;
  }

  static String dateFormat(String substring) {
    print('before: $substring');
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(substring);
    var outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    var outputDate = outputFormat.format(inputDate);
    print('after: $outputDate');
    return outputDate;
  }

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
        finalDateToFormat = DateFormat('EEE, dd MMM').format(DateTime.parse(substring));
      }

      print('format to convert Date: $finalDateToFormat');
      return finalDateToFormat;
    } catch (e) {
      return substring;
    }
  }


}
