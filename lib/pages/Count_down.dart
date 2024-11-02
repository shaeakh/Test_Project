import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountDown extends StatefulWidget {
  final TimeOfDay lunchTime;

  const CountDown({Key? key, required this.lunchTime}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> with SingleTickerProviderStateMixin {
  late Duration _timeRemaining;
  late Timer _timer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0.8,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  void _startCountdown() {
    final now = TimeOfDay.now();
    final nowDateTime = DateTime.now();
    final lunchDateTime = DateTime(
      nowDateTime.year,
      nowDateTime.month,
      nowDateTime.day,
      widget.lunchTime.hour,
      widget.lunchTime.minute,
    );

    _timeRemaining = lunchDateTime.difference(nowDateTime);

    if (_timeRemaining.isNegative) {
      _timeRemaining = Duration.zero;
      _triggerApiCall();
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _timeRemaining -= Duration(seconds: 1);
        });

        if (_timeRemaining <= Duration.zero) {
          _timer.cancel();
          _triggerApiCall();
        }
      });
    }
  }

  void _triggerApiCall() async {
    const apiUrl = 'https://your-api-endpoint.com';

    try {
      final response = await http.get(Uri.parse(apiUrl));
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
              Text(
                "Countdown to Lunch",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                _timeRemaining <= Duration.zero
                    ? "Lunch time!"
                    : _formatTime(_timeRemaining),
                style: TextStyle(
                  color: _timeRemaining <= Duration.zero
                      ? Colors.greenAccent
                      : Colors.redAccent,
                  fontSize: 80,
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_timeRemaining > Duration.zero)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Time Remaining",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
