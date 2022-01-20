// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uni_light/core/authentication.dart';
import 'package:uni_light/utils/constants.dart';
import 'package:uni_light/widgets/my_button.dart';
import 'package:uni_light/widgets/my_text.dart';
import 'package:uni_light/widgets/my_text_field.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  String? chooseGender, chooseInterest, year;

  final TextEditingController _date = TextEditingController();
  final TextEditingController _university = TextEditingController();
  final TextEditingController _course = TextEditingController();
  DateTime? bDate;

  File? image;

  bool _validateInput(BuildContext context) {
    if (_date.text.trim().isEmpty || _university.text.trim().isEmpty || _course.text.trim().isEmpty || chooseGender == null || chooseInterest == null || year == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No field can be empty'),
          backgroundColor: kRedColor,
        ),
      );
      return false;
    } else if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must select a profile picture'),
          backgroundColor: kRedColor,
        ),
      );
      return false;
    }
    return true;
  }

  void getImage() async {
    final ImagePicker _picker = ImagePicker();
    var temp = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(temp!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    // File? image = context.watch<UserController>().image;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/component_3.png',
                  height: 280,
                ),
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 12, right: 6),
                        child: image == null
                            ? Image.asset(
                                'assets/images/component_4.png',
                                height: 127,
                              )
                            : Image.file(
                                image!,
                                height: 127,
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 0,
                        child: Image.asset(
                          'assets/images/camera.png',
                          height: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: MyText(
                      paddingBottom: 15.0,
                      text: 'About me'.toUpperCase(),
                      size: 16,
                      weight: FontWeight.w500,
                      fontFamily: 'Roboto Mono',
                      color: kBlackColor,
                    ),
                  ),
                  MyText(
                    paddingBottom: 10.0,
                    text: 'I identify myself as',
                    size: 14,
                    color: kBlackColor,
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children: List.generate(
                          identifyMySelf.length,
                          (index) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  chooseGender = identifyMySelf[index];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: chooseGender == identifyMySelf[index] ? kRedColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: MyText(
                                    text: identifyMySelf[index],
                                    size: 14,
                                    color: chooseGender == identifyMySelf[index] ? kPrimaryColor : kGreyColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyText(
                    paddingBottom: 10.0,
                    text: 'Interested in',
                    size: 14,
                    color: kBlackColor,
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children: List.generate(
                          interestedIn.length,
                          (index) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  chooseInterest = interestedIn[index];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: chooseInterest == interestedIn[index] ? kRedColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: MyText(
                                    text: interestedIn[index],
                                    size: 14,
                                    color: chooseInterest == interestedIn[index] ? kPrimaryColor : kGreyColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    hintText: 'Birth date',
                    controller: _date,
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1995),
                        lastDate: DateTime(2100),
                      );
                      bDate = date;
                      _date.text = "${date!.year}-${date.month}-${date.day}";
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  MyTextField(
                    hintText: 'University',
                    controller: _university,
                  ),
                  MyTextField(
                    hintText: 'Course',
                    controller: _course,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyText(
                    paddingBottom: 10.0,
                    text: 'Year of study',
                    size: 14,
                    color: kBlackColor,
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children: List.generate(
                          yearOfStudy.length,
                          (index) => Expanded(
                            flex: index == 0 ? 3 : 1,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  year = yearOfStudy[index];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: year == yearOfStudy[index] ? kGreenColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: MyText(
                                    text: yearOfStudy[index],
                                    size: 12,
                                    color: year == yearOfStudy[index] ? kPrimaryColor : kGreyColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: kWidth(context) * 0.55,
              child: MyButton(
                text: 'NEXT',
                shadowColor: kRedColor,
                onPressed: () {
                  bool isValid = _validateInput(context);
                  if (isValid) {
                    var data = {
                      "gender": chooseGender,
                      "university": _university.text.trim(),
                      "course_name": _course.text.trim(),
                      "year": year,
                      "intrested_in": chooseInterest,
                      "photo": image,
                      "birth_day": bDate,
                    };
                    context.read<Authentication>().setData(data);

                    context.read<Authentication>().next();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
