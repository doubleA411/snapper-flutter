import 'package:fluent_ui/fluent_ui.dart';

class GlobalData extends ChangeNotifier {
  double paddingValue;
  double borderValue;
  double shadowValue;
  // ignore: prefer_typing_uninitialized_variables
  var img;

  List<Color> colorList1 = [];

  GlobalData(
      {this.borderValue = 0.0,
      this.paddingValue = 0.0,
      this.shadowValue = 0.0,
      this.img,
      this.colorList1 = const []});

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

  void changeImg(var newValue) {
    img = newValue;
    notifyListeners();
  }

  void assignColor(newValue) {
    colorList1 = newValue;
    notifyListeners();
  }
}
