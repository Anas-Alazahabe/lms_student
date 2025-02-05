import 'package:flutter/material.dart';
import 'package:lms_student/constants.dart';

class UnitSection extends StatelessWidget {
  const UnitSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 6,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Intoduction to dart',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: kAppColor,
                size: 30,
              ),
              onPressed: () {},
            ),
          );
        });
  }
}
