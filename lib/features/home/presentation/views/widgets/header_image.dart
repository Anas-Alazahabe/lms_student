import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/utils/assets.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';

class HeaderImage extends StatelessWidget {
  final String imageUrl;
  const HeaderImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: '$kBaseUrlAsset/$imageUrl',
            progressIndicatorBuilder: (context, url, progress) {
              return const CustomLoading();
            },
            errorWidget: (context, url, error) {
              return Image.asset(AssetsData.logo);
            },
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            // child: ElevatedButton(
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all(Colors.black54),
            //     shape: MaterialStateProperty.all(
            //       RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(50),
            //       ),
            //     ),
            //   ),
            //   onPressed: () {
            //     context.pop();
            //   },
            //    child: const Icon(Icons.arrow_forward),
            // ),
          ),
        )
      ],
    );
  }
}
