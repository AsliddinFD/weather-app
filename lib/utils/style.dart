import 'package:flutter/material.dart';

const customInputStyle = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(14),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(14),
    ),
  ),
  hintText: 'Enter a City name',
);

final customButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.grey,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
    side: const BorderSide(
      color: Colors.grey,
    ),
  ),
  fixedSize: const Size(100, 50),
  elevation: 0.3,
);

const customTextStyle = TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold, color: Color(0XFF2C3444));

// const  customTextStyleForSmaller = TextStyle(
//   fontSize: 15,
//   fontWeight: FontWeight.bold,
//   color: Color(0XFF2C3444)
// );

TextStyle customTextStyleForSmaller(int time) {
  if (time > 18) {
    return const TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);
  } else {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Color(0XFF2C3444),
    );
  }
}
