import 'package:flutter/material.dart';

// Colors
const kPrimaryColor = Colors.blue;
const kSecondaryColor = Colors.green;
const kTextColor = Colors.black;

// Text Styles
const kHeadingTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: kTextColor,
);

const kButtonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

// Button Style
ButtonStyle kElevatedButtonStyle(Color color) {
  return ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 18),
    backgroundColor: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    textStyle: kButtonTextStyle,
  );
}
