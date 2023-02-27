import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import 'global_data.dart';

class NewWidget extends StatefulWidget {
  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GlobalData>(context);

    return SizedBox(
      child: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: Provider.of<GlobalData>(context).colorList1),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.all(Provider.of<GlobalData>(context).paddingValue),
              child: Container(
                key: const Key("image"),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Provider.of<GlobalData>(
                      context,
                    ).borderValue,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10.0,
                      spreadRadius:
                          Provider.of<GlobalData>(context, listen: false)
                              .shadowValue,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  image: provider.img != null
                      ? DecorationImage(
                          fit: BoxFit.fill,
                          image: MemoryImage(provider.img),
                          scale: 3,
                        )
                      : const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("lib/assets/logo-text.png"),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
