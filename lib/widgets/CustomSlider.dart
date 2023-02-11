// ignore: file_names
import 'package:fluent_ui/fluent_ui.dart';

// ignore: must_be_immutable
class CustomSlider extends StatefulWidget {
  final String title;
  double value;
  CustomSlider({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(widget.title), Text("${widget.value.toInt()}")],
        ),
        Slider(
          value: widget.value,
          onChanged: (v) => setState(() => widget.value = v),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
