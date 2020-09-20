import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      home: ParentWidget(),
    );
  }
}

class ParentWidget extends StatefulWidget {
  ParentWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Life Cycle'),
      ),
      body: Provider.value(
        value: _counter,
        updateShouldNotify: (oldValue, newValue) => true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Press Fab button to increase counter:',
              ),
              ChildWidget()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  @override
  _ChildWidgetState createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  int _counter = 0;

  @override
  void initState() {
    print('initState(), counter = $_counter');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _counter = Provider.of<int>(context);
    print('didChangeDependencies(), counter = $_counter');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build(), counter = $_counter');
    return Text(
      '$_counter',
    );
  }
}
