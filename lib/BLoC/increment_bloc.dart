import 'dart:async';
import 'package:budget_friend/BLoC/blocbase.dart';

enum CounterEvent {increment, decrement}

class IncrementBLoC extends BlocBase
{
  int _counter = 0;

  IncrementBLoC()
  {
    _counter = 0;
    counterSink.add(_counter);
    eventStream.listen(_handleLogic);
  }

  StreamController _eventStreamController = StreamController<CounterEvent>();
  StreamSink<CounterEvent> get eventSink => _eventStreamController.sink;
  Stream <CounterEvent> get eventStream => _eventStreamController.stream;

  StreamController _counterStreamController = StreamController<int>();
  Stream<int> get counterStream => _counterStreamController.stream;
  StreamSink<int> get counterSink => _counterStreamController.sink;

  _handleLogic(CounterEvent event)
  {
    switch(event)
    {
      case CounterEvent.decrement:
        _counter -= 1;
        _counterStreamController.sink.add(_counter);
        break;
      case CounterEvent.increment:
        _counter += 1;
        _counterStreamController.sink.add(_counter);
        break;
    }
  }

  @override
  void dispose() {
    _counterStreamController.close();
    _eventStreamController.close();
  }
}