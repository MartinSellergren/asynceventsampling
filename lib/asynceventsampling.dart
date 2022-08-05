library asynceventsampling;

import 'dart:async';

import 'package:stream_transform/stream_transform.dart';

class AsyncEventSampling {
  final streamController = StreamController<Future<void> Function()>.broadcast();
  late final StreamSubscription subscription;

  AsyncEventSampling() {
    subscription = streamController.stream.asyncMapSample((event) => event()).listen((_) {});
  }

  void dispose() {
    subscription.cancel();
    streamController.close();
  }

  void addEvent(Future<void> Function() event) {
    streamController.add(event);
  }
}
