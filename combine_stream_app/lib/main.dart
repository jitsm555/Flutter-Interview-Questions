import 'package:async/async.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static Stream<String> stream1 = new Stream.fromFuture(getData(1));
  static Stream<String> stream2 = new Stream.fromFuture(getData(5));
  static Stream<String> stream3 = new Stream.fromFuture(getData(10));
  var streams = StreamGroup.merge([stream1, stream2, stream3]);
  String _value = "Nothing";

  static Future<String> getData(int duration) async {
    await Future.delayed(Duration(seconds: duration));
    return "This is a test data for duration $duration";
  }

  void _fetchData() async {
    StreamQueue data = StreamQueue(streams);
    String value;
    value = await data.next;
    setState(() {
      _value = value;
    });
    value = await data.next;
    setState(() {
      _value = value;
    });
    value = await data.next;
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(),
      body: Column(
        children: [
          Text(_value),
          RaisedButton(onPressed: () {
            _fetchData();
          }, child: Text("Fetch Data"),),
        ],

      ),
    );
  }
}

