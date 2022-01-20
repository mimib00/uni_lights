// import 'package:flutter/material.dart';
// import 'package:uni_light/utils/constants.dart';

// class ProfileImage extends StatelessWidget {
//   const ProfileImage({
//     Key? key,
//     this.bgColor = kOrangeColor,
//     this.image,
//   }) : super(key: key);
//   final Color? bgColor;
//   final String? image;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 53,
//       height: 53,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(100),
//         boxShadow: [
//           BoxShadow(
//             color: bgColor!,
//             spreadRadius: 0,
//             blurRadius: 10,
//             offset: const Offset(0.0, 2),
//           ),
//         ],
//       ),
//       child: Theme(
//         data: Theme.of(context).copyWith(
//           canvasColor: Colors.transparent,
//           cardColor: Colors.transparent,
//         ),
//         child: Card(
//           elevation: 3,
//           margin: const EdgeInsets.all(6),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: Center(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: image!.isNotEmpty || image != null
//                   ? Image.network(
//                       image!,
//                       height: kHeight(context),
//                       width: kWidth(context),
//                       fit: BoxFit.fitWidth,
//                     )
//                   : const Icon(
//                       Icons.person,
//                       color: Colors.white,
//                     ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uni_light/utils/constants.dart';

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
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: bgColor!,
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
                imageUrl: image!,
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
