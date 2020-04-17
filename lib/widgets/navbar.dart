import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int index;

  const Navbar({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Color(0xA0000000),
      selectedItemColor: Colors.white,
//      onTap: onTabTapped, // new
      currentIndex: index,
      // new
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rss_feed),
          title: Text('Feed'),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile'))
      ],
    );
  }
}
