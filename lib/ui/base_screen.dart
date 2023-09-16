import 'package:flutter/material.dart';

/// BaseScreen class making for common function and using in any ui class by extend BaseScreen class.
abstract class BaseScreen<T extends StatefulWidget> extends State<T> {
  bool _visibleProgress = false;
  late StateSetter _progressBarState;

  static BuildContext? _context;

  @override
  void initState() {
    super.initState();
    _context = context;
  }

  /// get circular progress bar
  Widget circularProgressBar() {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      _progressBarState = setState;
      return Visibility(
        visible: _visibleProgress,
        child: const AbsorbPointer(child: Center(child: CircularProgressIndicator())),
      );
    });
  }

  /// show progress bar
  void showProgress() {
    _progressBarState(() {
      _visibleProgress = true;
    });
  }

  /// hide progress bar
  void hideProgress() {
    _progressBarState(() {
      _visibleProgress = false;
    });
  }

  /// get current screen context
  static BuildContext? getContext() {
    return _context;
  }
}
