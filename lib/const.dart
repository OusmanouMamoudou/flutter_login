import 'package:flutter/material.dart';

// InputDecoration for generic input fields
const kInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1.0),
    borderRadius: kRadius,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2.0),
    borderRadius: kRadius,
  ),
);

const kRadius = BorderRadius.all(Radius.circular(32.0));
