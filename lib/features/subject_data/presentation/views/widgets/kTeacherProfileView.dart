import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/utils/assets.dart';

import 'subject_teachers.dart';

class TeacherProfileView extends StatefulWidget {
  const TeacherProfileView({super.key});

  @override
  State<TeacherProfileView> createState() => _TeacherProfileViewState();
}

class _TeacherProfileViewState extends State<TeacherProfileView> {
  int isProfilesuction = 0;
  var width, height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isProfilesuction = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: kAppColor,
                ),
                onPressed: () {
                  context.pop();
                },
              );
            },
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.favorite_border_outlined,
                size: 25,
                color: kAppColor,
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage(AssetsData.profile),
                      height: 50,
                      width: 50,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Welcom'.tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Masa Shalan',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xfff5f3ff),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        color: isProfilesuction == 0
                            ? kAppColor
                            : kAppColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isProfilesuction = 0;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 18),
                            child: Text(
                              'personal Info'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Material(
                        color: isProfilesuction == 1
                            ? kAppColor
                            : kAppColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isProfilesuction = 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 25),
                            child: Text(
                              'Subject'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Material(
                        color: isProfilesuction == 2
                            ? kAppColor
                            : kAppColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isProfilesuction = 2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: Text(
                              'Quizes'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (isProfilesuction == 0)
                profileinfo()
              else if (isProfilesuction == 1)
                subjectteachers()
              else
                Text('data'),
            ],
          ),
        ),
      ),
    );
  }
}

class profileinfo extends StatelessWidget {
  const profileinfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Icon(
              //   Icons.date_range_outlined,
              //   size: 20,
              //   color: Colors.black38,
              // ),
              SizedBox(width: 4),
              Text(
                'EMAIL'.tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'userexample@gmial.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[900],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              // Icon(
              //   Icons.home_outlined,
              //   color: Colors.grey[600],
              //   size: 20,
              // ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Address:'.tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Damas',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[900],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              // Icon(
              //   Icons.email_outlined,
              //   size: 20,
              //   color: Colors.black38,
              // ),
              SizedBox(width: 4),
              Text(
                'Date of Birth:'.tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            '1990/8/8',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[900],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              // Icon(
              //   Icons.check_circle_outline,
              //   size: 20,
              //   color: Colors.black38,
              // ),
              SizedBox(width: 4),
              Text(
                'Exist'.tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Yes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[900],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
