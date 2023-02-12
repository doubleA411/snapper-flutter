// ignore: file_names
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:snapper/global_data.dart';

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
  var value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(widget.title)],
        ),
        Slider(
            value: widget.value,
            onChanged: (v) {
              setState(() {
                if (widget.title == "Padding") {
                  Provider.of<GlobalData>(context, listen: false).paddingValue =
                      v;
                } else if (widget.title == "Border Radius") {
                  Provider.of<GlobalData>(context, listen: false).borderValue =
                      v;
                } else if (widget.title == "Shadow") {
                  Provider.of<GlobalData>(context, listen: false).shadowValue =
                      v;
                }

                widget.value = v;
              });
            })
      ],
    );
  }
}
