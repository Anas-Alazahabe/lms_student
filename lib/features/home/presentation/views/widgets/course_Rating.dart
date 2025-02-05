import 'package:flutter/material.dart';

class CourseRating extends StatelessWidget {
  const CourseRating({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          color: Color(0xFFFFDD4F),
          size: 10,
        ),
        const SizedBox(
          width: 6.3,
        ),
        Text(
          '4.8',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '(3200)',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
