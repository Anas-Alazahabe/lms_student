import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/utils/app_router.dart';
import 'package:lms_student/core/utils/assets.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/features/home/data/models/ad_model/ad.dart';

class AdItem extends StatelessWidget {
  const AdItem({
    super.key,
    required this.ad,
  });
  final Ad ad;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          context.push(AppRouter.kAdView, extra: ad);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: '$kBaseUrlAsset${ad.imageUrl}',
            progressIndicatorBuilder: (context, url, progress) {
              return const CustomLoading();
            },
            errorWidget: (context, url, error) {
              return Image.asset(AssetsData.logo);
            },
          ),
        ),
      ),
    );
  }
}
