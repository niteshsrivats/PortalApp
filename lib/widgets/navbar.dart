import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int index;
  final bool post;

  const Navbar({Key key, @required this.index, @required this.post}) : super(key: key);

  void _onTap(BuildContext context, int index) {
    if (!post) {
      index += 1;
    }
    if (index != this.index) {
      switch (index) {
        case 0:
          if (this.index == 1) {
            Navigator.pushNamed(context, '/post');
          } else {
            Navigator.pushReplacementNamed(context, '/post');
          }
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/');
          break;
        case 2:
          if (this.index == 1) {
            Navigator.pushNamed(context, '/profile');
          } else {
            Navigator.pushReplacementNamed(context, '/profile');
          }
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [];
    if (post) {
      items = [BottomNavigationBarItem(icon: Icon(Icons.add_comment), title: Text('New Post'))];
    }
    items.addAll([
      BottomNavigationBarItem(icon: Icon(Icons.rss_feed), title: Text('Feed')),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile'))
    ]);

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Color(0xA0000000),
      selectedItemColor: Colors.white,
      onTap: (int index) => _onTap(context, index),
      // new
      currentIndex: post ? index : index - 1,
      // new
      items: items,
    );
  }
}
