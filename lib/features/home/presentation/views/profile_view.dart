import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/utils/assets.dart';
import 'package:lms_student/features/auth/data/models/user_model/user.dart';

class ProfileView extends StatelessWidget {
  final Box<User> user;
  ProfileView({super.key, required this.user});
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Color(0xffd4e2d1),
        width: width,
        child: Column(
          children: [
            Container(
              height: height * 0.35,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: (AssetImage(AssetsData.pp))),
                //color: kAppColor,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 30),
                        child: Text(
                          'My Profile'.tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.65,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.person_outline_sharp,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      '${user.values.first.name}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        color: kAppColor,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit_outlined,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.email_outlined,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      ' ${user.values.first.email}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        color: kAppColor,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit_outlined,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.date_range_outlined,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      ' ${user.values.first.birthDate}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        color: kAppColor,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit_outlined,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    //SafeArea(
    // child: Scaffold(
    // appBar: AppBar(
    // title: const Text('الملف الشخصي'),
    // ),
    // body: Padding(
    // padding: const EdgeInsets.all(16.0),
    //child: SingleChildScrollView(
    //child: Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    // crossAxisAlignment: CrossAxisAlignment.stretch,
    // children: <Widget>[
    // const Spacer(),
    // CircleAvatar(
    // radius: 50,
    //child: Text(
    // user.values.first.name![0],
    // style: const TextStyle(fontSize: 40.0, color: Colors.white),
    //),
    // ),
    //const SizedBox(height: 20),
    //Card(
    //child: Padding(
    // padding: const EdgeInsets.all(8.0),
    //child: Text(
    // 'الاسم: ${user.values.first.name}',
    // style: const TextStyle(
    //   fontSize: 20, fontWeight: FontWeight.bold),
    //),
    //),
    //),
    // const SizedBox(height: 10),
    //Card(
    //child: Padding(
    //padding: const EdgeInsets.all(8.0),
    //child: Text(
    // 'اسم الأب: ${user.values.first.birthDate}',
    //style: const TextStyle(fontSize: 18),
    //),
    //),
    //),
    //const SizedBox(height: 10),
    // Card(
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Text(
    //       'اجمالي النقاط: ${sharedPreferencesCubit.getPoints()}',
    //       style: const TextStyle(fontSize: 18),
    //     ),
    //   ),
    // ),
    // const Spacer(),
    // Row(
    //   children: [
    //     const Spacer(),
    //     Card(
    //         child: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Text('ID:${sharedPreferencesCubit.getId()}'),
    //     )),
    //   ],
    // )

    //TODO continue the data here
    //],
    //),
    //),
    //),
    //),
    //);
  }
}
