import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:front_end/pages/home_subpages/about_us.dart';
import 'package:front_end/pages/home_subpages/chill_page.dart';
import 'package:front_end/pages/home_subpages/room_locator.dart';
import 'package:front_end/pages/home_subpages/table_maker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [
    ChillPage(),
    RoomLocatorPage(),
    TableMakerPage(),
    AboutUsPage()
  ];
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: pages[selectedIndex],
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "home"),
            NavigationDestination(
                icon: Icon(Icons.room), label: "Room Locator"),
            NavigationDestination(
                icon: Icon(Icons.schedule), label: "TableMaker"),
            NavigationDestination(icon: Icon(Icons.info), label: "About Us"),
          ],
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          selectedIndex: selectedIndex,
        ),
      ),
    );
    ;
  }
}
