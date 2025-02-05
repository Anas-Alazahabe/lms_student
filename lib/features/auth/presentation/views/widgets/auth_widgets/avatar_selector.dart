import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms_student/core/utils/assets.dart';

class AvatarSelector extends StatefulWidget {
  final void Function(int selectedAvatarIndex) setAvatar;
  const AvatarSelector({super.key, required this.setAvatar});

  @override
  AvatarSelectorState createState() => AvatarSelectorState();
}

class AvatarSelectorState extends State<AvatarSelector> {
  int selectedAvatarIndex = 0;

  @override
  void initState() {
    super.initState();
    // selectedAvatarIndex = Random().nextInt(AssetsData.avatars.length);
    // widget.setAvatar(selectedAvatarIndex!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Your Profile',
          style: GoogleFonts.inter(
            color: Color(0xFF17505E),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: AssetsData.avatars.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // setState(() {
                          selectedAvatarIndex = index;
                          // });
                          widget.setAvatar(selectedAvatarIndex);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.asset(AssetsData.avatars[index]),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          child: CircleAvatar(
            radius: 80,
            backgroundImage:
                AssetImage(AssetsData.avatars[selectedAvatarIndex]),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Welcome',
          style: GoogleFonts.inter(
            color: Color(0xFF17505E),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Tell us more about yourself!',
          style: GoogleFonts.inter(
            color: Color(0xFF17505E),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
