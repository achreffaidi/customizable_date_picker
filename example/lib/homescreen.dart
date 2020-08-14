import 'package:flutter/material.dart';
import 'testScreens/business.dart';
import 'testScreens/default.dart';
import 'testScreens/pink.dart';
import 'testScreens/spiderman.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBody() {
    return IndexedStack(
        index: _currentIndex,
        children: allDestinations.map<Widget>((Destination destination) {
          return getDestinationWidget(destination: destination);
        }).toList() )  ;

  }

  Widget _getBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: allDestinations.map((Destination destination) {
        return BottomNavigationBarItem(
            icon: Icon(destination.icon),
            backgroundColor: destination.color,
            title: Text(destination.title)
        );
      }).toList(),
    );
  }
}

Widget getDestinationWidget({Destination destination}) {
  switch (destination.title)  {
    case "Default" : return  DefaultDemo();
    case "SpiderMan" : return  SpiderManDemo();
    case "Pink" : return  PinkDemo();
    case "Business" : return  BusinessDemo();
  }
  return Container();
}
class Destination {
  const Destination(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final MaterialColor color;
}
const List<Destination> allDestinations = <Destination>[
  Destination('Default', Icons.looks_one, Colors.teal),
  Destination('SpiderMan', Icons.looks_two, Colors.cyan),
  Destination('Pink', Icons.looks_3, Colors.orange),
  Destination('Business', Icons.looks_4, Colors.blue)
];


