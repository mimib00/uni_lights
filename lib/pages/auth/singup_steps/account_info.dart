// ignore_for_file: must_be_immutable, prefer_final_fields

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_light/core/authentication.dart';
import 'package:uni_light/utils/constants.dart';
import 'package:uni_light/widgets/my_button.dart';
import 'package:uni_light/widgets/my_text.dart';
import 'package:uni_light/widgets/my_text_field.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({Key? key}) : super(key: key);

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  Future<bool> _validateInput(BuildContext context) async {
    if (_name.text.trim().isEmpty || _email.text.trim().isEmpty || _password.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No field can be empty'),
          backgroundColor: kRedColor,
        ),
      );
      return false;
    } else if (_name.text.trim().length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name must be more than 3 characters long'),
          backgroundColor: kRedColor,
        ),
      );
      return false;
    } else if (!EmailValidator.validate(_email.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email is not valid'),
          backgroundColor: kRedColor,
        ),
      );
      return false;
    } else if (await context.read<Authentication>().userExist(_email.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There is already an account with this email.'),
          backgroundColor: kRedColor,
        ),
      );
      return false;
    } else if (_password.text.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be more than 6 character long'),
          backgroundColor: kRedColor,
        ),
      );
      return false;
    } else if (_password.text.trim() != _confirmPassword.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password and Confirm password doesn\'t match'),
          backgroundColor: kRedColor,
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/component_3.png',
                height: 280,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 12, right: 6),
                child: Image.asset(
                  'assets/images/component_4.png',
                  height: 127,
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
                    text: 'Create a new account'.toUpperCase(),
                    size: 16,
                    weight: FontWeight.w500,
                    fontFamily: 'Roboto Mono',
                    color: kBlackColor,
                  ),
                ),
                MyTextField(
                  hintText: 'Name',
                  controller: _name,
                ),
                MyTextField(
                  hintText: 'Email',
                  controller: _email,
                ),
                MyTextField(
                  hintText: 'Password',
                  obsecure: true,
                  haveSuffixIcon: true,
                  controller: _password,
                ),
                MyTextField(
                  hintText: 'Re-type password',
                  obsecure: true,
                  haveSuffixIcon: true,
                  controller: _confirmPassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: kWidth(context) * 0.55,
                    child: MyButton(
                      text: 'NEXT',
                      shadowColor: kRedColor,
                      onPressed: () async {
                        bool isValid = await _validateInput(context);
                        if (isValid) {
                          var data = {
                            "name": _name.text.trim(),
                            "email": _email.text.trim(),
                            "password": _password.text.trim(),
                          };
                          context.read<Authentication>().setData(data);
                          context.read<Authentication>().next();
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      color: kGreyColor,
                    ),
                    children: [
                      TextSpan(text: 'This app is dedicated strictly for '),
                      TextSpan(
                        text: '18 years ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                          color: kGreyColor,
                        ),
                      ),
                      TextSpan(text: 'and over students. By creating an account you agree with our'),
                      TextSpan(
                        text: ' Terms of Use ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                          color: kGreyColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: 'and'),
                      TextSpan(
                        text: ' Privacy Policy',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: kGreyColor, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: MyText(
                    text: 'Who can register?',
                    size: 13,
                    weight: FontWeight.w500,
                    color: kRedColor,
                    fontFamily: 'Roboto',
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
