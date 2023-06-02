import 'package:flutter/material.dart';

class LoadingDialog {
  static OverlayEntry? _overlayEntry;

  static void showLoadingDialog(BuildContext context, String msg) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Dialog(
        child: Container(
          color: Colors.white,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  msg,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hideLoadingDialog() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
