import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_student/constants.dart';

class Navigationbar extends StatelessWidget {
  final ValueChanged<int> onItemTapped;

  const Navigationbar({
    Key? key,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          gap: 8,
          activeColor: kAppColor,
          //Theme.of(context).primaryColor,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          tabBackgroundColor: Theme.of(context).colorScheme.onSecondary,

          tabs: [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.heart,
              text: 'Favorite',
            ),
            GButton(
              icon: LineIcons.bookmarkAlt,
              text: 'Bookmark',
            ),
            // GButton(
            //   icon: LineIcons.user,
            //   text: 'Profile',
            // ),
          ],
          selectedIndex: 0, // Default selected index
          onTabChange: onItemTapped, // Call the callback with the index
        ),
      ),
    );
  }
}
