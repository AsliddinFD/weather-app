import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/style.dart';
import 'package:frontend/widgets/forecast_widget.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.city,
    required this.country,
    required this.icon,
    required this.tempC,
    required this.wind,
    required this.tempF,
    required this.date,
    required this.forecast,
    required this.iconText,
  });

  final String city;
  final String country;
  final String icon;
  final String wind;
  final double tempC;
  final double tempF;
  final String date;
  final List forecast;
  final String iconText;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int parsedDate;
    try {
      parsedDate = int.parse(widget.date);
    } catch (e) {
      parsedDate = 0;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(255, 114, 114, 114),
      ),
      backgroundColor: parsedDate > 18 ? const Color(0XFF2C3444) : Colors.white,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${widget.city}, ${widget.country}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://${widget.icon}',
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                  ],
                ),
                Text(
                  widget.iconText,
                  style: customTextStyle,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.tempC.toStringAsFixed(1)}°C',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: parsedDate > 13
                            ? const Color(0xFF2C3444)
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.tempF.toStringAsFixed(1)}°F',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: parsedDate > 13
                            ? const Color(0xFF2C3444)
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.wind,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.wind,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.forecast.length,
                    itemBuilder: (context, index) {
                      return Forecast(forecast: widget.forecast[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
