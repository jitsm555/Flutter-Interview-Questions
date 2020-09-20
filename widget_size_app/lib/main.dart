import "package:flutter/material.dart";
import 'package:flutter/scheduler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SizeWidget(),
    );
  }
}

class SizeWidget extends StatefulWidget {
  @override
  _SizeWidgetState createState() => _SizeWidgetState();
}

class _SizeWidgetState extends State<SizeWidget> {
  final GlobalKey _textKey = GlobalKey();
  Size textSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print("parent didChangeDependencies");
    super.didChangeDependencies();
  }

  getSizeAndPosition() {
    RenderBox _cardBox = _textKey.currentContext.findRenderObject();
    textSize = _cardBox.size;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("parent build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Size Position"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Currern Size of Text",
            key: _textKey,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          WidgetSize(
            onChange: (Size size) {
              /// TODO: Another way to get size, you can assign size to text like below
              /// textSize = size
            },
            child: Text(
              "Size - $textSize",
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(onPressed: () {
            setState(() {
              textSize = Size(1.0, 2.0);
            });
          })
        ],
      ),
    );
  }
}

class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function onChange;

  const WidgetSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant WidgetSize oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
