import 'package:flutter/material.dart';
import 'package:headers/screens/slide_show_screen.dart';

class LayoutModel with ChangeNotifier {
  Widget _currenScreen = SlideShowScreen();

  set currentScreen(Widget screen) {
    this._currenScreen = screen;
    notifyListeners();
  }

  Widget get currentScreen => this._currenScreen;
}
