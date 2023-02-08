import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:app22/homePage.dart';
import 'package:app22/list_page.dart';
import 'utils/constants.dart';
import 'charts_page.dart';

class NavPage extends StatefulWidget {
  NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 65,
        backgroundColor: kOrange_main4,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: "Selection",
          ),
          NavigationDestination(
            icon: Icon(Icons.add_chart_sharp),
            label: "Charts",
          ),
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int value) {
          setState(() {
            currentPageIndex = value;
          });
        },
      ),
      body: [
        HomePage(),
        List_page(),
        Charts_page(),
      ][currentPageIndex],
    );
  }
}
