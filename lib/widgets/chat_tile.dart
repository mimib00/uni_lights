import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uni_light/pages/home/screens/inbox/chat_screen.dart';
import 'package:uni_light/utils/constants.dart';

import 'my_text.dart';

class ChatTile extends StatefulWidget {
  final String chatId;
  final String userName, userPhoto;
  final String lastMessage;
  final String? time;
  final String status;
  const ChatTile({
    Key? key,
    required this.userName,
    required this.userPhoto,
    required this.chatId,
    required this.status,
    required this.lastMessage,
    this.time,
  }) : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  bool? onLongPress = false;

  @override
  Widget build(BuildContext context) {
    Color bgColor = kGreenColor;
    switch (widget.status) {
      case "It's complicated":
        setState(() {
          bgColor = kOrangeColor;
        });
        break;
      case "Signle":
        setState(() {
          bgColor = kGreenColor;
        });
        break;
      case "In a relationship":
        setState(() {
          bgColor = kRedColor;
        });

        break;
      default:
    }

    return GestureDetector(
      onTap: () {
        // chat screen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              id: widget.chatId,
              name: widget.userName,
              photo: widget.userPhoto,
            ),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 90,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileImage(
                  image: widget.userPhoto,
                  bgColor: bgColor,
                ),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  paddingLeft: 20.0,
                                  text: widget.userName,
                                  size: 16,
                                  weight: FontWeight.w500,
                                  color: kBlackColor,
                                  fontFamily: 'Roboto Mono',
                                ),
                                MyText(
                                  paddingLeft: 10.0,
                                  text: widget.time,
                                  size: 13,
                                  color: kGreyColor3,
                                  fontFamily: 'Roboto',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      MyText(
                                        text: widget.lastMessage.isEmpty ? "No messages start the conversation" : widget.lastMessage,
                                        size: 13,
                                        maxlines: 2,
                                        paddingTop: 5.0,
                                        paddingLeft: 10.0,
                                        paddingRight: 15.0,
                                        align: TextAlign.justify,
                                        overFlow: TextOverflow.ellipsis,
                                        color: kGreyColor,
                                        fontFamily: 'Roboto',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    this.bgColor = kOrangeColor,
    required this.image,
  }) : super(key: key);
  final Color bgColor;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 53,
      height: 53,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: bgColor,
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0.0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
          cardColor: Colors.transparent,
        ),
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.all(6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => const Icon(Icons.person, color: Colors.white),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
                height: kHeight(context),
                width: kWidth(context),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
