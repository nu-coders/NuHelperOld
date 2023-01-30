import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  String room;
  String course;
  String status;
  RoomCard(
      {super.key,
      required this.course,
      required this.room,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 12, 12, 12),
      margin: const EdgeInsets.all(10),
      height: 85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 106, 183, 255)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Room: $room",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Course: $course",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  status,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Icon(Icons.location_city)
              ],
            ),
          )
        ],
      ),
    );
  }
}
