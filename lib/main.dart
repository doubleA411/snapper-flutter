import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:snapper/widgets/CustomSlider.dart';
import 'package:window_manager/window_manager.dart';

import 'global_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitle("Snapper");
    await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.setMinimumSize(const Size(755, 700));
    await windowManager.setSize(const Size(1100, 700));
    await windowManager.center();
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GlobalData(),
      child: FluentApp(
        debugShowCheckedModeBanner: false,
        title: "Snapper",
        theme: FluentThemeData(
          brightness: Brightness.light,
          accentColor: Colors.red,
        ),
        darkTheme: FluentThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.red,
        ),
        home: const MyHomePage(title: ""),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GlobalData>(context, listen: false);
    var paddingValue = provider.paddingValue;
    var borderValue = provider.borderValue;
    var shadowValue = provider.shadowValue;
    return NavigationView(
      content: Row(children: [
        Acrylic(
          child: Container(
            width: 300,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xffFF9595).withOpacity(0.14),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSlider(
                    title: "Padding",
                    value: paddingValue,
                  ),
                  CustomSlider(
                    title: "Border Radius",
                    value: borderValue,
                  ),
                  CustomSlider(
                    title: "Shadow",
                    value: shadowValue,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Background"),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      ColorWidget(colors: [
                        Color(0xffFC3B3B),
                        Color(0xffF66565),
                        Color(0xffEE9999),
                        Color(0xffEE9A9A),
                      ]),
                      ColorWidget(colors: [
                        Color(0xffFF8A00),
                        Color(0xffFAC715),
                      ]),
                      ColorWidget(colors: [
                        Color(0xff56E9FD),
                        Color(0xff337E88),
                      ]),
                      ColorWidget(colors: [
                        Color(0xffA10EFB),
                        Color(0xff006ED3),
                        Color(0xff6957C0),
                        Color(0xffEF39A6),
                      ])
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      ColorWidget(colors: [
                        Color(0xffFC3B3B),
                        Color(0xffF66565),
                        Color(0xffEE9999),
                        Color(0xffEE9A9A),
                      ]),
                      ColorWidget(colors: [
                        Color(0xffFF8A00),
                        Color(0xffFAC715),
                      ]),
                      ColorWidget(colors: [
                        Color(0xff56E9FD),
                        Color(0xff337E88),
                      ]),
                      ColorWidget(colors: [
                        Color(0xffA10EFB),
                        Color(0xff006ED3),
                        Color(0xff6957C0),
                        Color(0xffEF39A6),
                      ])
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text("Size"),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      Chip(
                        text: Text("Twitter"),
                      ),
                      Chip(
                        text: Text("Instagram"),
                      ),
                      Chip(
                        text: Text("Facebook"),
                      ),
                      Chip(
                        text: Text("LinkedIn"),
                      ),
                      Chip(
                        text: Text("Snapchat"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: SizedBox(
            child: Padding(
              padding:
                  EdgeInsets.all(Provider.of<GlobalData>(context).paddingValue),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Provider.of<GlobalData>(
                      context,
                    ).borderValue),
                    color: Colors.red),
              ),
            ),
          ),
        )
      ]),
      //
    );
  }
}

class ColorWidget extends StatelessWidget {
  final List<Color> colors;
  const ColorWidget({
    super.key,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
