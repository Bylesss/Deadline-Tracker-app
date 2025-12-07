import 'package:flutter/material.dart';



class deadlineUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Deadlines'),
      ),
      body: Column(
        children: [Text('Upload your deadline CSV file here.',
        style: TextStyle(fontSize: 20),),
        ElevatedButton(
          onPressed: () {

          },
          child: Text('Upload CSV'),
        ),
        ],
      ),
    );
  }
}