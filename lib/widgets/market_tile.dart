import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_light/core/authentication.dart';
import 'package:uni_light/pages/home/screens/profile/profile_screen.dart';
import 'package:uni_light/utils/constants.dart';
import 'package:uni_light/widgets/my_text.dart';

class DiscountsTiles extends StatefulWidget {
  final String? pic, name, time, description;
  final String? uid;
  final String? owner;
  final List? postImages, tags;
  final double? price;
  final Color? bgColor;

  const DiscountsTiles({
    Key? key,
    this.uid,
    this.owner,
    this.bgColor,
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
  bool? reportUser = false;

  void showReportUser() {
    setState(() {
      reportUser = true;
    });
  }

  void hideReportUser() {
    setState(() {
      reportUser = false;
    });
  }

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
                bgColor: widget.bgColor,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () => showReportUser(),
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: kGreyColor3,
                                    size: 30,
                                  ),
                                ),
                              ],
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
                    reportUser == true
                        ? GestureDetector(
                            onTap: () => hideReportUser(),
                            child: Container(
                              height: 250,
                              width: kWidth(context),
                              color: kPrimaryColor.withOpacity(0.4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 50,
                                      right: 15,
                                    ),
                                    width: 117,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [
                                          kRedColor,
                                          kRedColor,
                                          kPrimaryColor,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/images/entypo_block.png',
                                          color: kPrimaryColor,
                                          height: 15,
                                        ),
                                        MyText(
                                          text: 'Report this post',
                                          size: 10,
                                          weight: FontWeight.w500,
                                          color: kPrimaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
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

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    this.bgColor = kOrangeColor,
    this.image,
  }) : super(key: key);
  final Color? bgColor;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 53,
      height: 53,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: bgColor!,
            spreadRadius: 0,
            blurRadius: 10,
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
              child: image!.isNotEmpty || image != null
                  ? Image.network(
                      image!,
                      height: kHeight(context),
                      width: kWidth(context),
                      fit: BoxFit.fitWidth,
                    )
                  : const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/*widget.singlePost == true
                                  ? const SizedBox()
                                  : Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 5,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            '${widget.postImage1}',
                                            width: kWidth(context),
                                            height: kHeight(context),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                              widget.singlePost == true
                                  ? const SizedBox()
                                  : Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            '${widget.postImage2}',
                                            width: kWidth(context),
                                            height: kHeight(context),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                              widget.singlePost == true
                                  ? Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 5,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            '${widget.post}',
                                            width: kWidth(context),
                                            height: kHeight(context),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),*/
