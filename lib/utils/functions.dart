import 'package:intl/intl.dart';

String kphToMps(double kph) {
  const double conversionFactor = 0.277778;
  num metersPerSecond = (kph * conversionFactor).round();

  return '${metersPerSecond}m/s';
}

int extractDate(String inputDate) {
  String dateTimeString = "2023-09-29 23:04";

  DateTime dateTime = DateTime.parse(dateTimeString);

  String date = DateFormat('yyyy-MM-dd').format(dateTime);
  String time = DateFormat('HH:mm').format(dateTime);
  
  return int.parse(date);
}

String formatDate(String inputDate) {
  final parsedDate = DateTime.parse(inputDate.toString().replaceAll('.', '-'));

  final outputFormat = DateFormat('EEEE, MMMM d', 'en_US');

  final formattedDate = outputFormat.format(parsedDate);

  return formattedDate;
}
