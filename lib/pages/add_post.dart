import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Start',
      home: MySettings(),
    );
  }
}

class MySettings extends StatefulWidget {
  MySettings({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MySettingsState createState() => _MySettingsState();
}

class Category {
  int id;
  String name;
  String image;
  bool isSelected;
  Category({this.id, this.name, this.isSelected = false, this.image});
}

class _MySettingsState extends State<MySettings> {
  final TextEditingController tweetController = TextEditingController();
  void nothing() {}
  Color _myColorS = Colors.white;
  Color _myColorD = Colors.white;
  Color _myColorC = Colors.white;
  List<bool> isSelected = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          centerTitle: false,
          leading: IconButton(
            onPressed: () => nothing,
            color: Colors.blue,
            icon: Icon(Icons.close),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: RaisedButton(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                color: Colors.blue,
                onPressed: () => nothing,
                child: Text(
                  "Post",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return Container(
              height: constraint.maxHeight,
              width: constraint.maxWidth,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 40.0,
                        height: 40.0,
                        margin: EdgeInsets.only(right: 24.0),
                        child: Icon(
                          Icons.account_circle,
                          size: 60.0,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                          width: 250.0,
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: tweetController,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.0,
                                  color: Colors.transparent,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(0.0),
                              labelText: "Write Your Post...",
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            autocorrect: false,
                          ))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 270.0, top: 100.0),
                          child: Text("Semesters",
                              style: TextStyle(fontSize: 25))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("Semeste 1"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorS,
                              onPressed: () {
                                setState(() {
                                  if (_myColorS == Colors.blue) {
                                    _myColorS = Colors.white;
                                  } else {
                                    _myColorS = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("Semester 2"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorD,
                              onPressed: () {
                                setState(() {
                                  if (_myColorD == Colors.blue) {
                                    _myColorD = Colors.white;
                                  } else {
                                    _myColorD = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("Semester 4"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorC,
                              onPressed: () {
                                setState(() {
                                  if (_myColorC == Colors.blue) {
                                    _myColorC = Colors.white;
                                  } else {
                                    _myColorC = Colors.blue;
                                  }
                                });
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("Semeste 1"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorS,
                              onPressed: () {
                                setState(() {
                                  if (_myColorS == Colors.blue) {
                                    _myColorS = Colors.white;
                                  } else {
                                    _myColorS = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("Semester 2"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorD,
                              onPressed: () {
                                setState(() {
                                  if (_myColorD == Colors.blue) {
                                    _myColorD = Colors.white;
                                  } else {
                                    _myColorD = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("Semester 4"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorC,
                              onPressed: () {
                                setState(() {
                                  if (_myColorC == Colors.blue) {
                                    _myColorC = Colors.white;
                                  } else {
                                    _myColorC = Colors.blue;
                                  }
                                });
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("Semeste 1"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorS,
                              onPressed: () {
                                setState(() {
                                  if (_myColorS == Colors.blue) {
                                    _myColorS = Colors.white;
                                  } else {
                                    _myColorS = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("Semester 2"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorD,
                              onPressed: () {
                                setState(() {
                                  if (_myColorD == Colors.blue) {
                                    _myColorD = Colors.white;
                                  } else {
                                    _myColorD = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("Semester 4"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorC,
                              onPressed: () {
                                setState(() {
                                  if (_myColorC == Colors.blue) {
                                    _myColorC = Colors.white;
                                  } else {
                                    _myColorC = Colors.blue;
                                  }
                                });
                              })
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 260.0, top: 30.0),
                          child: Text("Department",
                              style: TextStyle(fontSize: 25))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("CSE"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorS,
                              onPressed: () {
                                setState(() {
                                  if (_myColorS == Colors.blue) {
                                    _myColorS = Colors.white;
                                  } else {
                                    _myColorS = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("ISE"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorD,
                              onPressed: () {
                                setState(() {
                                  if (_myColorD == Colors.blue) {
                                    _myColorD = Colors.white;
                                  } else {
                                    _myColorD = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("ECE"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorC,
                              onPressed: () {
                                setState(() {
                                  if (_myColorC == Colors.blue) {
                                    _myColorC = Colors.white;
                                  } else {
                                    _myColorC = Colors.blue;
                                  }
                                });
                              })
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 280.0, top: 30.0),
                          child:
                              Text("Section", style: TextStyle(fontSize: 25))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("A"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorS,
                              onPressed: () {
                                setState(() {
                                  if (_myColorS == Colors.blue) {
                                    _myColorS = Colors.white;
                                  } else {
                                    _myColorS = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("B"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorD,
                              onPressed: () {
                                setState(() {
                                  if (_myColorD == Colors.blue) {
                                    _myColorD = Colors.white;
                                  } else {
                                    _myColorD = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("C"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorC,
                              onPressed: () {
                                setState(() {
                                  if (_myColorC == Colors.blue) {
                                    _myColorC = Colors.white;
                                  } else {
                                    _myColorC = Colors.blue;
                                  }
                                });
                              })
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 320.0, top: 30.0),
                          child: Text("Year", style: TextStyle(fontSize: 25))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("1st"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorS,
                              onPressed: () {
                                setState(() {
                                  if (_myColorS == Colors.blue) {
                                    _myColorS = Colors.white;
                                  } else {
                                    _myColorS = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("2nd"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorD,
                              onPressed: () {
                                setState(() {
                                  if (_myColorD == Colors.blue) {
                                    _myColorD = Colors.white;
                                  } else {
                                    _myColorD = Colors.blue;
                                  }
                                });
                              }),
                          new RaisedButton(
                              elevation: 0,
                              child: new Text("3rd"),
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                              color: _myColorC,
                              onPressed: () {
                                setState(() {
                                  if (_myColorC == Colors.blue) {
                                    _myColorC = Colors.white;
                                  } else {
                                    _myColorC = Colors.blue;
                                  }
                                });
                              })
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new RaisedButton(
                                elevation: 0,
                                child: new Text("4th"),
                                shape: StadiumBorder(
                                    side: BorderSide(color: Colors.black)),
                                color: _myColorS,
                                onPressed: () {
                                  setState(() {
                                    if (_myColorS == Colors.blue) {
                                      _myColorS = Colors.white;
                                    } else {
                                      _myColorS = Colors.blue;
                                    }
                                  });
                                }),
                          ])
                    ],
                  ),
                ]),
              ));
        }));
  }
}
