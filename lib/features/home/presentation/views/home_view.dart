import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lms_student/constants.dart';
import 'package:lms_student/core/cubits/token_cubit/token_cubit.dart';
import 'package:lms_student/core/utils/service_locator.dart';
import 'package:lms_student/features/auth/data/models/user_model/user.dart';
import 'package:lms_student/features/home/presentation/views/widgets/book_mark.dart';
import 'package:lms_student/features/home/presentation/views/widgets/favorite_view.dart';
import 'package:lms_student/firebase_options.dart';
import 'package:overlay_support/overlay_support.dart';

import 'widgets/home_drawer.dart';
import 'widgets/home_view_body.dart';
import 'widgets/navigation_bar.dart';

class HomeView extends StatefulWidget {
  // final String? gradeId;
  const HomeView({
    super.key,
    //  required this.gradeId
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final token = getIt<TokenCubit>();
  // final savedData = getIt<SharedPreferencesCubit>();
  var box = Hive.box<User>(kUser);
  int _selectedPageIndex = 0;
  final rand = Random().nextInt(34);
  late final List<Widget> _pages;









  void setAppNotification() async {
    if (token.state != null) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseMessaging.instance.requestPermission();

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          showSimpleNotification(
              Text(notification.title ?? '',
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text(notification.body ?? '',
                  style: const TextStyle(color: Colors.white)),
              background: Colors.black54,
              elevation: 5);
        }
      });
    }
  }











  @override
  void initState() {
    super.initState();

    _pages = [
      Builder(builder: (context) {
        return HomeViewBody(
          rand: rand,
          action: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      FavoriteView(),
      const BookMark(),
      Container(),
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: HomeDrawer(
          user: box,
        ),
        body: _pages[_selectedPageIndex],
        bottomNavigationBar: Navigationbar(
          onItemTapped: _selectPage,
        ),
      ),
    );
  }
}
