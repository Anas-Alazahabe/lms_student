import 'package:flutter/material.dart';
import 'package:lms_student/constants.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  int isbookmark = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isbookmark = 0;
  }

  var height, width;
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: Color(0xffebe6e0),
      child: Column(
        children: [
          Container(
            width: width,
            height: 70,
            decoration: BoxDecoration(
              color: kAppColor,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.bookmark,
                    color: Color(0xffebe6e0),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'BookMark',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffebe6e0),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
              // color: Color(0xfff5f3ff),
              color: Color(0xffebe6e0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Material(
                  color:
                      isbookmark == 0 ? kAppColor : kAppColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isbookmark = 0;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                      child: Text(
                        'Units',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Material(
                  color:
                      isbookmark == 1 ? kAppColor : kAppColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isbookmark = 1;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                      child: Text(
                        'Lessons',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
