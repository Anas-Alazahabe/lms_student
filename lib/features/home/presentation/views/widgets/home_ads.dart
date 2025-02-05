import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/cubits/base_cubit/base_cubit.dart';
import 'package:lms_student/core/utils/size_config.dart';
import 'package:lms_student/core/widgets/custom_error.dart';
import 'package:lms_student/features/home/data/models/ad_model/ad_model.dart';
import 'package:lms_student/features/home/presentation/manager/ad_cubit.dart';
import 'package:shimmer/shimmer.dart';

import 'ad_item.dart';

class HomeAds extends StatelessWidget {
  const HomeAds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdCubit, BaseState>(
      builder: (context, state) {
        if (state is Failure) {
          return SizedBox(
              height: SizeConfig.height * .2,
              child: CustomError(errMessage: state.errorMessage));
        }
        if (state is Loading) {
          return SizedBox(
            width: 1000,
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.white,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          // height: 150,
                          // width: 200,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )),
                );
              },
            ),
          );
        }
        if (state is Success<AdModel>) {
          // state.data as AdModel;
          if (state.data.message != null && state.data.message!.isEmpty) {
            return SizedBox(
                height: SizeConfig.height * .2,
                child: Center(
                    child: Text(
                  'لا يوجد اعلانات',
                  style: Theme.of(context).textTheme.bodyLarge,
                )));
          }
          return CarouselSlider.builder(
            itemCount: state.data.message!.length,

            //  itemCount: 10,
            itemBuilder: (context, index, realIndex) {
              return AdItem(
                ad: state.data.message![index],
              );
              //  return Image.asset(AssetsData.logo);
            },
            options: CarouselOptions(
                disableCenter: true,
                viewportFraction: 0.6,
                height: SizeConfig.height * .2,
                aspectRatio: 16 / 9,
                pauseAutoPlayOnTouch: true,
                autoPlay: true),
          );
        }
        return Container();
      },
    );
  }
}
