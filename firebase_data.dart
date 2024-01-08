import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Data from Firestore'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('grades').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available.'));
          }

          final grades = snapshot.data!.docs.map((doc) => doc.data()).toList();

          return ListView.builder(
            itemCount: grades.length,
            itemBuilder: (context, index) {
              final gradeData = grades[index] as Map<String,
                  dynamic>?; // Cast to Map and handle potential null
              return ListTile(
                title: Text(
                    'Subject: ${gradeData != null ? gradeData['subject'] : 'N/A'}'),
                subtitle: Text(
                    'Average: ${gradeData != null ? gradeData['average'] : 'N/A'}'),
                trailing: Text(
                    'Grade: ${gradeData != null ? gradeData['grade'] : 'N/A'}'),
              );
            },
          );
        },
      ),
    );
  }
}
