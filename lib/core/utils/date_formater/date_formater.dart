import 'package:intl/intl.dart';

class DateFormater {
  static DateTime stringToDate(String dateString){

    // Adding the current year or a default year to the string
    String formattedString = '$dateString 2024';

    // Define the format of the input string
    DateFormat format = DateFormat('EEE, d MMM yyyy');

    DateTime parsedDate = format.parse(formattedString);

    print(parsedDate);
    return parsedDate;
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
        finalDateToFormat =
            DateFormat('EEE, dd MMM').format(DateTime.parse(substring));
      }

      return finalDateToFormat;
    } catch (e) {
      return substring;
    }
  }
}
