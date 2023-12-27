import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/result_screen.dart';
import 'package:frontend/utils/functions.dart';
import 'package:frontend/utils/style.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatelessWidget {
  final textController = TextEditingController();

  void showWarning(String msg, BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    } else if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }
  }

  void getWeather(String city, BuildContext context) async {
    if (city.isEmpty) {
      showWarning('Please enter the region name', context);
    } else {
      city = city[0].toUpperCase() + city.substring(1);
      print(city);
      final url = Uri.https(
        'weatherapi-com.p.rapidapi.com',
        '/forecast.json',
        {'q': '$city', 'days': '3'},
      );
      final headers = {
        'X-RapidAPI-Key': 'f4cb8acfc3msh40a8531540557b7p13b60bjsn42a17350d3c9',
        'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com',
      };

      try {
        final response = await http.get(url, headers: headers);

        if (response.statusCode == 200 && context.mounted) {
          final responseData = json.decode(response.body);

          final country = responseData['location']['country'];
          final iconText = responseData['current']['condition']['text'];
          final icon = responseData['current']['condition']['icon']
              .toString()
              .substring(2);
          final tempC = responseData['current']['temp_c'];
          final tempF = responseData['current']['temp_f'];
          final wind = responseData['current']['wind_mph'];
          final date = responseData['location']['localtime'][11] +
              responseData['location']['localtime'][12];

          final forecast = responseData['forecast'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                city: city,
                country: country,
                iconText: iconText,
                icon: icon,
                tempC: tempC,
                wind: kphToMps(wind).toString(),
                tempF: tempF,
                date: date,
                forecast: forecast['forecastday'],
              ),
            ),
          );
        } else if (context.mounted) {
          showWarning(
              'Please make sure that you have typed correct region name',
              context);
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: customInputStyle,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  getWeather(textController.text, context);
                },
                style: customButtonStyle,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
