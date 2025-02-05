import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/utils/app_styles.dart';
import 'package:lms_student/core/utils/assets.dart';
import 'package:lms_student/core/widgets/custom_loading.dart';
import 'package:lms_student/features/home/data/models/ad_model/ad.dart';

class AdDetailsView extends StatelessWidget {
  final Ad ad;
  const AdDetailsView({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    //TODO add hero animation
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تفاصيل الإعلان'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
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
              const SizedBox(
                height: 24,
              ),
              Center(
                  child: Text(
                ad.description!,
                style: AppStyles.styleSemiBold24(context),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
