import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int index;

  const Navbar({Key key, @required this.index}) : super(key: key);

  void _onTap(BuildContext context, int index) {
    if (index != this.index) {
      switch (index) {
        case 0:
          if (this.index == 1) {
            Navigator.pushNamed(context, '/newpost');
          } else {
            Navigator.pushReplacementNamed(context, '/');
          }
          break;
        case 1:
          Navigator.popUntil(context, ModalRoute.withName('/'));
          break;
        case 2:
          if (this.index == 1) {
            Navigator.pushNamed(context, '/profile');
          } else {
            Navigator.pushReplacementNamed(context, '/');
          }
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Color(0xA0000000),
      selectedItemColor: Colors.white,
      onTap: (int index) => _onTap(context, index), // new
      currentIndex: index,
      // new
      items: [
//        BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Settings')),
        BottomNavigationBarItem(icon: Icon(Icons.add_comment), title: Text('New Post')),
        BottomNavigationBarItem(icon: Icon(Icons.rss_feed), title: Text('Feed')),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile'))
      ],
    );
  }
}
