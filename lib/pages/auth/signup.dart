// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uni_light/core/authentication.dart';
import 'package:uni_light/widgets/my_app_bar.dart';

import 'singup_steps/about_me.dart';
import 'singup_steps/account_info.dart';
import 'singup_steps/know_each_other.dart';
import 'singup_steps/light_pick.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  List steps = [
    const LightPicker(),
    AccountInfo(),
    const AboutMe(),
    const KnowEachOther(),
  ];

  @override
  Widget build(BuildContext context) {
    int index = context.watch<Authentication>().step;
    return Scaffold(
      appBar: MyAppBar(
        haveBackButton: true,
        backButtonOnTap: () {
          context.read<Authentication>().disposed();
          Navigator.of(context).pop();
        },
      ),
      body: steps[index],
    );
  }
}
