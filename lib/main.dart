import 'package:budget_friend/BLoC/increment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter BLoC Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  IncrementBLoC _incrementBLoC = IncrementBLoC();

  @override
  void dispose()
  {
    _incrementBLoC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _incrementBLoC.counterStream,
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  snapshot.data.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            );
          },
        ),
      ),
      persistentFooterButtons: <Widget>[
        Container(
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed: ()
                {
                  _incrementBLoC.eventSink.add(CounterEvent.increment);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: ()
                {
                  _incrementBLoC.eventSink.add(CounterEvent.decrement);
                },
                tooltip: 'Increment',
                child: Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
