
  import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/utils/app_router.dart';

Future<dynamic> kickUserDialog(BuildContext context) {
    return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ),
                    Center(
                      child: AlertDialog(
                        content: const Text(
                            'يجب اعادة تسجيل الدخول للوصول للبيانات'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('تسجيل الدخول'),
                            onPressed: () {
                              context
                                  .pushReplacement(AppRouter.kOnBoardingView);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
  }