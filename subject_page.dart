import 'package:flutter/material.dart';
import 'result_page.dart'; // Import Page3 for navigation
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_data.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final PageController _pageController = PageController(initialPage: 0);
  TextEditingController subjectController = TextEditingController();
  TextEditingController tmController = TextEditingController();
  TextEditingController utsController = TextEditingController();
  TextEditingController uasController = TextEditingController();

  double average = 0.0; // Store the calculated average
  String grade = ''; // Store the calculated grade

  void calculate() {
    double tr = double.tryParse(tmController.text) ?? 0.0;
    double uts = double.tryParse(utsController.text) ?? 0.0;
    double uas = double.tryParse(uasController.text) ?? 0.0;

    setState(() {
      average = (tr * 0.2) + (uts * 0.3) + (uas * 0.5);
      grade = getGrade(average);
    });
  }

  String getGrade(double score) {
    // Implement your grade calculation logic here
    if (score >= 90) {
      return 'A';
    } else if (score >= 85) {
      return 'A-';
    } else if (score >= 80) {
      return 'B+';
    } else if (score >= 75) {
      return 'B';
    } else if (score >= 70) {
      return 'B-';
    } else if (score >= 65) {
      return 'C';
    } else if (score >= 50) {
      return 'D';
    } else if (score >= 0) {
      return 'E';
    } else {
      return 'F';
    }
  }

  void saveDataToFirebase() {
    FirebaseFirestore.instance.collection('grades').add({
      'subject': subjectController.text,
      'average': average,
      'grade': grade,
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Nilai Mata Kuliah'),
        centerTitle: true, // Ini akan membuat judul berada di tengah
      ),
      body: PageView(
        controller: _pageController,
        children: [
          // Page 1: Input Subject
          _buildSubjectPage(),
          // Page 2: Input Scores
          _buildScorePage(),
        ],
      ),
    );
  }

  Widget _buildSubjectPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Input field for subject
          TextFormField(
            controller: subjectController,
            decoration: InputDecoration(labelText: 'Subject'),
          ),
          // Next button to navigate to the score input page
          ElevatedButton(
            onPressed: () {
              _pageController.nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildScorePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Input fields for subject scores (use TextFormFields)
          TextFormField(
            controller: tmController,
            decoration: InputDecoration(labelText: 'TR Score'),
          ),
          TextFormField(
            controller: utsController,
            decoration: InputDecoration(labelText: 'UTS Score'),
          ),
          TextFormField(
            controller: uasController,
            decoration: InputDecoration(labelText: 'UAS Score'),
          ),

          // Calculate button to calculate average and grade
          ElevatedButton(
            onPressed: calculate,
            child: Text('Calculate'),
          ),

          // Display average and grade
          Text('Average: ${average.toStringAsFixed(2)}'),
          Text('Grade: $grade'),

          // Save button to save data to Firebase
          ElevatedButton(
            onPressed: () {
              saveDataToFirebase();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Page3(average: average, grade: grade),
                ),
              );
            },
            child: Text('Save to Firebase'),
          ),
          // Previous button to navigate back to subject input page
          ElevatedButton(
            onPressed: () {
              _pageController.previousPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            child: Text('Previous'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AllDataPage(), // Navigate to FirebaseDataPage
                ),
              );
            },
            child: Text('View Firebase Data'),
          ),
        ],
      ),
    );
  }
}
