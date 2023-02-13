import 'package:fluent_ui/fluent_ui.dart';

class GlobalData extends ChangeNotifier {
  double paddingValue;
  double borderValue;
  double shadowValue;
  GlobalData(
      {this.borderValue = 0.0,
      this.paddingValue = 0.0,
      this.shadowValue = 0.0});

  void changePadding(var newValue) {
    paddingValue = newValue;
    notifyListeners();
  }

  void changeBorder(var newValue) {
    borderValue = newValue;
    notifyListeners();
  }

  void changeShadow(var newValue) {
    shadowValue = newValue;
    notifyListeners();
  }
}
