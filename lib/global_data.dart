import 'package:fluent_ui/fluent_ui.dart';

class GlobalData extends ChangeNotifier {
  double paddingValue;
  double borderValue;
  double shadowValue;
  // ignore: prefer_typing_uninitialized_variables
  var img;

  List<Color> colorList1 = [];

  GlobalData(
      {this.borderValue = 10.0,
      this.paddingValue = 70.0,
      this.shadowValue = 0.0,
      this.img,
      this.colorList1 = const [
        Color(0xffFC3B3B),
        Color(0xffF66565),
        Color(0xffEE9999),
        Color(0xffEE9A9A),
      ]});

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
