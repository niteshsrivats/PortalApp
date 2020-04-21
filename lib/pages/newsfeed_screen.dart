import 'package:college_main/providers/auth_service.dart';
import 'package:college_main/providers/defaults_service.dart';
import 'package:college_main/providers/post_service.dart';
import 'package:college_main/providers/user_service.dart';
import 'package:college_main/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NewsfeedScreen extends StatefulWidget {
  @override
  _NewsfeedScreenState createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  PostService _postService;
  DefaultsService _defaultsService;
  UserService _userService;
  AuthService _authService;
  static const bodyText = 'Lorem ipsum dolor sit amet, consectetur adipisi adipisicing elit. Asperiores aut dignissimos dolorem dolorum ducimus fuga in, numquam odio pariatur possimus quasi sint sunt ut? Placeat.';
  static const author = '\n- Adhyayan Panwar';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _postService = Provider.of<PostService>(context, listen: false);
    _defaultsService = Provider.of<DefaultsService>(context, listen: false);
    _userService = Provider.of<UserService>(context, listen: false);
    _authService = Provider.of<AuthService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          onPressed: () => _authService.signOut(),
        ),
        title: Icon(
          Icons.language,
          color: Theme.of(context).primaryColor,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_list),
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            onPressed: () => print("Filter"),
          ),
        ],
      ),
      bottomNavigationBar: const Navbar(index: 1),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 3,
            margin: const EdgeInsets.only(top: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.account_circle,
                      size: 56, color: Colors.grey),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 24, 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Text(
                                    'Nitesh Srivats',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '6A CSE',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              '3hr',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: const Text(
                            bodyText,
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.thumb_up, color: Colors.grey),
                            const SizedBox(width: 4),
                            const Text(
                              '223',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.comment, color: Colors.grey),
                            const SizedBox(width: 4),
                            const Text(
                              '78',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  color: Colors.grey,
                                  icon: Icon(Icons.share),
                                  onPressed: () => Share.share(bodyText + author),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
