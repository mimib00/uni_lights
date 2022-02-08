import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_light/core/authentication.dart';
import 'package:uni_light/core/data_manager.dart';
import 'package:uni_light/pages/home/screens/profile/profile_screen.dart';
import 'package:uni_light/utils/constants.dart';
import 'package:uni_light/widgets/my_text.dart';
import 'package:uni_light/widgets/profile_image.dart';

class DiscountsTiles extends StatefulWidget {
  final String? pic, name, time, description;
  final String? uid;
  final String? owner;
  final List? postImages, tags;
  final double? price;
  final String? status;

  const DiscountsTiles({
    Key? key,
    this.uid,
    this.owner,
    this.status,
    this.pic,
    this.name,
    this.time,
    this.description,
    this.postImages,
    this.price,
    this.tags,
  }) : super(key: key);

  @override
  State<DiscountsTiles> createState() => _DiscountsTilesState();
}

class _DiscountsTilesState extends State<DiscountsTiles> {
  @override
  Widget build(BuildContext context) {
    var user = context.read<Authentication>().user!;
    Widget? photos;

    if (widget.postImages?.length == 1) {
      photos = Container(
        margin: const EdgeInsets.only(
          top: 15,
          bottom: 10.0,
          right: 10.0,
        ),
        height: 120,
        width: kWidth(context),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 5,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ImagePreview(
              imageLink: widget.postImages!.first,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: CachedNetworkImage(
                      imageUrl: widget.postImages!.first,
                      height: kHeight(context) * .4,
                      width: kWidth(context),
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
              width: kWidth(context),
              height: kHeight(context),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (widget.postImages?.length == 2) {
      photos = Container(
        margin: const EdgeInsets.only(
          top: 15,
          bottom: 10.0,
          right: 10.0,
        ),
        height: 120,
        width: kWidth(context),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 5,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImagePreview(
                    imageLink: widget.postImages!.first,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: CachedNetworkImage(
                            imageUrl: widget.postImages!.first,
                            height: kHeight(context) * .4,
                            width: kWidth(context),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                    width: kWidth(context) * .4,
                    height: kHeight(context),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 5,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImagePreview(
                    imageLink: widget.postImages!.last,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: CachedNetworkImage(
                            imageUrl: widget.postImages!.last,
                            height: kHeight(context) * .4,
                            width: kWidth(context),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                    width: kWidth(context),
                    height: kHeight(context),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    List tags = widget.tags!
        .map(
          (e) => MyText(
            text: "#$e",
            size: 9,
            weight: FontWeight.w300,
            color: kRedColor,
          ),
        )
        .toList();
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileImage(
                image: '${widget.pic}',
                status: widget.status!,
                height: 55,
                width: 55,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              paddingLeft: 15.0,
                              text: '${widget.name}',
                              size: 16,
                              weight: FontWeight.w500,
                              color: kBlackColor,
                              fontFamily: 'Roboto Mono',
                            ),
                            MyText(
                              text: '${widget.time}',
                              size: 10,
                              color: kGreyColor,
                              fontFamily: 'Roboto',
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Visibility(
                              visible: user.uid == widget.owner,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      color: kGreyColor3,
                                      size: 30,
                                    ),
                                    tooltip: "More",
                                    onSelected: (value) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Center(
                                            child: Text("Warning!"),
                                          ),
                                          titleTextStyle: const TextStyle(color: Colors.red, fontSize: 28),
                                          content: const Text("Are you sure you want to delete this post permanently?"),
                                          actionsAlignment: MainAxisAlignment.center,
                                          actions: [
                                            OutlinedButton(
                                              onPressed: () {
                                                context.read<DataManager>().deleteProduct(widget.uid!);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Yes"),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("No"),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    itemBuilder: (context) => [
                                      const PopupMenuItem<String>(
                                        child: Text(
                                          'Delete',
                                        ),
                                        value: "delete",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: '${widget.description}',
                                    size: 10,
                                    maxlines: 3,
                                    align: TextAlign.center,
                                    overFlow: TextOverflow.ellipsis,
                                    color: kGreyColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        photos!,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ...tags,
                            Row(
                              children: [
                                MyText(
                                  text: '${widget.price} £',
                                  size: 12,
                                  paddingRight: 15.0,
                                  weight: FontWeight.w600,
                                  color: kRedColor,
                                ),
                                Visibility(
                                  visible: widget.owner != user.uid,
                                  child: Image.asset(
                                    'assets/images/send.png',
                                    height: 35,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
