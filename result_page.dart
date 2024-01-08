import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  final double average;
  final String grade;

  Page3({required this.average, required this.grade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Average: $average'),
            Text('Grade: $grade'),
          ],
        ),
      ),
    );
  }
}
