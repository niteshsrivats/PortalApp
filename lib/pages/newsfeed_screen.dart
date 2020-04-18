import 'package:college_main/providers/post_service.dart';
import 'package:college_main/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsfeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PostService _postService = Provider.of<PostService>(context, listen: false);
    _postService.getPosts();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          onPressed: () => print("Settings"),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 3,
            margin: const EdgeInsets.only(top: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.account_circle, size: 56, color: Colors.grey),
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
                                    style: TextStyle(fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              '3hr',
                              style: TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipisi adipisicing elit. Asperiores aut dignissimos dolorem dolorum ducimus fuga in, numquam odio pariatur possimus quasi sint sunt ut? Placeat.',
                            style: TextStyle(fontSize: 14.0, color: Colors.black54),
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
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.comment, color: Colors.grey),
                            const SizedBox(width: 4),
                            const Text(
                              '78',
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                            Expanded(
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: const Icon(Icons.share, color: Colors.grey),
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
