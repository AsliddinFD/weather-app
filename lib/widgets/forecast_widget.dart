import 'package:flutter/material.dart';
import 'package:frontend/utils/functions.dart';
import 'package:frontend/utils/style.dart';

class Forecast extends StatelessWidget {
  const Forecast({Key? key, required this.forecast});
  final Map forecast;

  @override
  Widget build(BuildContext context) {
    final date = forecast['date'];
    final averageTempC = forecast['day']['avgtemp_c'];
    final averageTempF = forecast['day']['avgtemp_f'];
    final icon = forecast['day']['condition']['icon'].toString().substring(2);

    final dateHour = date.length >= 13 ? date[11] + date[12] : '';
    int? dateHourNumeric;

    try {
      dateHourNumeric = int.parse(dateHour);
    } catch (e) {
      dateHourNumeric = null;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          formatDate(date),
          style: customTextStyleForSmaller(dateHourNumeric ?? 0),
        ),
        Image.network('https://$icon'),
        Text(
          '$averageTempC°C|$averageTempF°F',
          style: customTextStyleForSmaller(dateHourNumeric ?? 0),
        ),
      ],
    );
  }
}
