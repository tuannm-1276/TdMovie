import 'dart:async';

import 'package:flutter/material.dart';
import 'package:td_movie/base/base_event.dart';
import 'package:td_movie/util/strings.dart';

abstract class BaseBloc {
  StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  Sink<BaseEvent> get event => _eventStreamController.sink;

  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception(Strings.invalidEvent);
      }

      handleEvent(event);
    });
  }

  void handleEvent(BaseEvent event);

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
  }
}
