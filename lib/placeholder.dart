import 'package:flutter/material.dart';
import 'profilePage.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySettings(title: 'Flutter Login'),
    );
  }
}

class MySettings extends StatefulWidget {
  MySettings({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MySettingsState createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final welcome = Text(
      "Settings will go here...",
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 40,
          fontFamily: 'Montserrat'),
    );
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 45.0,
                    ),
                    Align(alignment: Alignment.topLeft, child: welcome),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFeed(title: 'Flutter Login'),
    );
  }
}

class MyFeed extends StatefulWidget {
  MyFeed({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyFeedState createState() => _MyFeedState();
}

class _MyFeedState extends State<MyFeed> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(children: <Widget>[
            new Container(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.account_circle,
                                  size: 60.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                                child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: "Adhyayan",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                      color: Colors.black),
                                                ),
                                                TextSpan(
                                                    text: " 3m",
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.grey))
                                              ]),
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                            flex: 5,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: SingleChildScrollView(
                                                    child: Text(
                                                  "asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )))
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                Icons.comment,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.thumb_up,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.share,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ))),
            new Container(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.account_circle,
                                  size: 60.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                                child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: "Adhyayan",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                      color: Colors.black),
                                                ),
                                                TextSpan(
                                                    text: " 3m",
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.grey))
                                              ]),
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                            flex: 5,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: SingleChildScrollView(
                                                    child: Text(
                                                  "asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )))
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                Icons.comment,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.thumb_up,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.share,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ))),
            new Container(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.account_circle,
                                  size: 60.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                                child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: "Adhyayan",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                      color: Colors.black),
                                                ),
                                                TextSpan(
                                                    text: " 3m",
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.grey))
                                              ]),
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                            flex: 5,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: SingleChildScrollView(
                                                    child: Text(
                                                  "asdasdasdasdasdasdasdasdasdasdasdas",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )))
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                Icons.comment,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.thumb_up,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.share,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ))),
            new Container(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.account_circle,
                                  size: 60.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                                child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: "Adhyayan",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.0,
                                                      color: Colors.black),
                                                ),
                                                TextSpan(
                                                    text: " 3m",
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.grey))
                                              ]),
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                            flex: 5,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: SingleChildScrollView(
                                                    child: Text(
                                                  "asdasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasddasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )))
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Align(
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                Icons.comment,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.thumb_up,
                                                color: Colors.grey,
                                              ),
                                              Icon(
                                                Icons.share,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    )))
          ]),
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Profile Page',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primaryColor: Color(0xff0082CD), primaryColorDark: Color(0xff0082CD)),
      home: new ProfilePage(),
    );
  }
}
