import 'package:flutter/material.dart';

/// These are not constants but used frequently.
double kWidth(BuildContext context) => MediaQuery.of(context).size.width;

double kHeight(BuildContext context) => MediaQuery.of(context).size.height;

const kPrimaryColor = Color(0xffFFFFFF);
const kGreyColor = Color(0xff707070);
const kPostBackground = Color(0xffF2F2F2);
const kLightGreyColor = Color(0xffE0E0E0);
const kGreyColor2 = Color(0xff747272);
const kGreyColor3 = Color(0xffC4C4C4);
const kDarkGreyColor = Color(0xff434343);
const kBlackColor = Color(0xff373131);
const kRedColor = Color(0xffEF8484);
const kGreenColor = Color(0xffB4E6A7);
const kOrangeColor = Color(0xffFFB57F);
Color kBorderColor = const Color(0xff959595).withOpacity(0.51);

List identifyMySelf = [
  'Male',
  'Female',
  'Non-binary',
];
List interestedIn = [
  'Male',
  'Female',
  'Both',
];
List yearOfStudy = [
  'Joining in september',
  '1st',
  '2nd',
  '3rd',
  '4th',
];
List<String> light = [
  "Single",
  "It's complicated",
  "In a relationship"
];
final List<Color> lights = [
  kRedColor,
  kGreenColor,
  kOrangeColor,
];
