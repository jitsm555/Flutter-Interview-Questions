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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MemoizerSample(),
    );
  }
}

class FutureSample extends StatefulWidget {
  // Create instance variable
  @override
  _FutureSampleState createState() => _FutureSampleState();
}

class _FutureSampleState extends State<FutureSample> {
  Future myFuture;

  Future<String> _fetchData() async {
    await Future.delayed(Duration(seconds: 10));
    return 'DATA';
  }

  @override
  void initState() {
    // assign this variable your Future
    myFuture = _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: myFuture,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
             return Text(snapshot.data.toString());
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}


class MemoizerSample extends StatefulWidget {
  @override
  _MemoizerSampleState createState() => _MemoizerSampleState();
}

class _MemoizerSampleState extends State<MemoizerSample> {
  AsyncMemoizer _memoizer;

  _fetchData() async {
    return this._memoizer.runOnce(() async {
      await Future.delayed(Duration(seconds: 10));
      return 'DATA';
    });
  }

  @override
  void initState() {
    super.initState();
    _memoizer = AsyncMemoizer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: _fetchData(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
