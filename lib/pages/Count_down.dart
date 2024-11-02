import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountDown extends StatefulWidget {
  final TimeOfDay breakfastTime;
  final TimeOfDay lunchTime;
  final TimeOfDay dinnerTime;

  const CountDown({
    Key? key,
    required this.lunchTime,
    required this.breakfastTime,
    required this.dinnerTime,
  }) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> with SingleTickerProviderStateMixin {
  late Duration _breakfastRemaining;
  late Duration _lunchRemaining;
  late Duration _dinnerRemaining;
  late Timer _timer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initializeCountdowns();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0.8,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  void _initializeCountdowns() {
    final nowDateTime = DateTime.now();
    _breakfastRemaining = _getRemainingTime(nowDateTime, widget.breakfastTime);
    _lunchRemaining = _getRemainingTime(nowDateTime, widget.lunchTime);
    _dinnerRemaining = _getRemainingTime(nowDateTime, widget.dinnerTime);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _breakfastRemaining = _breakfastRemaining > Duration.zero
            ? _breakfastRemaining - Duration(seconds: 1)
            : Duration.zero;

        _lunchRemaining = _lunchRemaining > Duration.zero
            ? _lunchRemaining - Duration(seconds: 1)
            : Duration.zero;

        _dinnerRemaining = _dinnerRemaining > Duration.zero
            ? _dinnerRemaining - Duration(seconds: 1)
            : Duration.zero;

        if (_breakfastRemaining == Duration.zero) _triggerApiCall("Breakfast","https://tax-form-backaend.vercel.app/medicine/update");
        if (_lunchRemaining == Duration.zero) _triggerApiCall("Lunch","https://tax-form-backaend.vercel.app/medicine/update");
        if (_dinnerRemaining == Duration.zero) _triggerApiCall("Dinner","https://tax-form-backaend.vercel.app/medicine/update");
      });
    });
  }

  Duration _getRemainingTime(DateTime now, TimeOfDay targetTime) {
    final targetDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      targetTime.hour,
      targetTime.minute,
    );

    final difference = targetDateTime.difference(now);
    return difference.isNegative ? Duration.zero : difference;
  }

  void _triggerApiCall(String mealType,String apiUrl) async {

    const headers = {
      "Content-Type": "application/json",
    };

    final body = {
      "medId": "1",
      "medTimeKey": "after$mealType",  // Using string interpolation
      "medTimeValue": true,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('API call successful');
      } else {
        print('Failed to call API: ${response.statusCode}');
      }
    } catch (e) {
      print('Error calling API: $e');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ScaleTransition(
          scale: _animationController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCountdown("Breakfast", _breakfastRemaining),
              SizedBox(height: 20),
              _buildCountdown("Lunch", _lunchRemaining),
              SizedBox(height: 20),
              _buildCountdown("Dinner", _dinnerRemaining),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountdown(String mealName, Duration timeRemaining) {
    return Column(
      children: [
        Text(
          "Countdown to $mealName",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          timeRemaining <= Duration.zero ? "$mealName time!" : _formatTime(timeRemaining),
          style: TextStyle(
            color: timeRemaining <= Duration.zero ? Colors.greenAccent : Colors.redAccent,
            fontSize: 25,
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
          ),
        ),
        if (timeRemaining > Duration.zero)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Time Remaining",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}
