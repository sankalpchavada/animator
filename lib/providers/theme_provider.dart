import 'package:animator_app/models/theme_model.dart';
import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeDetail themeDetail = ThemeDetail(isDark: false);

  void changeTheme() {
    themeDetail.isDark = !themeDetail.isDark;
    notifyListeners();
  }
}
