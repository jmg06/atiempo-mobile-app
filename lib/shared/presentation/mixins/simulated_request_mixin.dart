import 'dart:async';

import 'package:flutter/widgets.dart';

/// Makes an action take as long as a server round trip would, since the prototype has no server.
mixin SimulatedRequestMixin<T extends StatefulWidget> on State<T> {
  static const Duration _roundTrip = Duration(milliseconds: 800);

  bool _isRequesting = false;

  bool get isRequesting => _isRequesting;

  /// Stays requesting until [onResponse] settles, so a screen that pushes the next one keeps its button working
  /// underneath and gets it back enabled on return. [onResponse] is skipped if something else navigated away
  /// during the wait.
  Future<void> simulateRequest(FutureOr<void> Function() onResponse) async {
    setState(() => _isRequesting = true);
    await Future<void>.delayed(_roundTrip);

    if (mounted && (ModalRoute.of(context)?.isCurrent ?? true)) {
      await onResponse();
    }
    if (mounted) {
      setState(() => _isRequesting = false);
    }
  }
}
