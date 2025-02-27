

import 'package:flutter/cupertino.dart';

class TabScreenViewModel with ChangeNotifier{
  int _selectedTabIndex = 0;

  int get selectedTabIndex => _selectedTabIndex;

  void setTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

}