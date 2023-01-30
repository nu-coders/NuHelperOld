import 'package:flutter/material.dart';

class RoomCardV2 extends StatelessWidget {
  String room;
  String course;
  String status;
  RoomCardV2(
      {super.key,
      required this.course,
      required this.room,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),

      // width: 200,
      height: 99,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromARGB(255, 224, 230, 231),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 255, 241, 241).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
            child: Text(
              room,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 63, 178, 255),
                // color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            padding: const EdgeInsets.fromLTRB(0, 15, 18, 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  status,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Text(
                  course,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
