import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_light/models/user.dart';
import 'package:uni_light/core/authentication.dart';
import 'package:uni_light/pages/home/screens/market/view_products.dart';
import 'package:uni_light/pages/settings.dart';
import 'package:uni_light/utils/constants.dart';
import 'package:uni_light/widgets/profile_image.dart';

import 'my_text.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Users user = context.read<Authentication>().user!;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -38,
          top: 42,
          child: GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/images/close_button.png',
              height: 40,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          child: Drawer(
            elevation: 4,
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ProfileImage(
                              image: user.photoURL!,
                              height: 200,
                              width: 200,
                              status: user.light!,
                            ),
                          ],
                        ),
                        MyText(
                          paddingTop: 10.0,
                          maxlines: 1,
                          overFlow: TextOverflow.ellipsis,
                          text: user.name,
                          fontFamily: 'Roboto Mono',
                          size: 24,
                          weight: FontWeight.w500,
                          color: kDarkGreyColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 10),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ViewProducts(),
                            ));
                          },
                          leading: Image.asset(
                            'assets/images/ic_outline-sell.png',
                            height: 26,
                          ),
                          title: MyText(
                            text: 'My announcements',
                            size: 20,
                            color: kDarkGreyColor,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SettingsPage(),
                              ),
                            );
                          },
                          leading: Image.asset(
                            'assets/images/fluent_settings-32-regular.png',
                            height: 25,
                          ),
                          title: MyText(
                            text: 'Settings',
                            size: 20,
                            weight: FontWeight.w500,
                            color: kDarkGreyColor,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                          },
                          leading: Image.asset(
                            'assets/images/akar-icons_sign-out.png',
                            height: 24,
                          ),
                          title: MyText(
                            text: 'Sign Out',
                            size: 20,
                            weight: FontWeight.w500,
                            color: kDarkGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyText(
                              text: 'About us',
                              size: 13,
                              color: kDarkGreyColor,
                            ),
                            MyText(
                              text: '|',
                              size: 13,
                              color: kDarkGreyColor,
                            ),
                            MyText(
                              text: 'Terms and conditions',
                              size: 13,
                              color: kDarkGreyColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
