import 'dart:async';
// import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:snapper/new_widget.dart';
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
  runApp(MultiProvider(
    providers: [
      Provider<GlobalData>(
        create: (context) => GlobalData(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GlobalData(),
        )
      ],
      builder: (context, child) {
        return FluentApp(
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
        );
      },
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
  final GlobalKey genKey = GlobalKey();
  Future readImages() async {
    final imageBytes = await Pasteboard.image;
    return imageBytes;
  }

  Future<void> takePicture() async {
    final RenderRepaintBoundary boundary =
        genKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    File imgFile = File('$directory/screenshots/$ts.png');
    imgFile.writeAsBytes(pngBytes);
  }

  var index = 0;
  // ignore: prefer_typing_uninitialized_variables
  var img;

  @override
  void initState() {
    readImages().then((value) {
      setState(() {
        Provider.of<GlobalData>(context, listen: false).changeImg(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GlobalData>(context);
    var paddingValue = provider.paddingValue;
    var borderValue = provider.borderValue;
    var shadowValue = provider.shadowValue;

    return NavigationView(
      content: Row(children: [
        Acrylic(
          child: Container(
            width: 250,
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
                      ColorWidget(
                        colors: [
                          Color(0xffFE0944),
                          Color(0xffFEAE96),
                        ],
                      ),
                      ColorWidget(colors: [
                        Color(0xffFF8A00),
                        Color(0xffFAC715),
                      ]),
                      ColorWidget(colors: [
                        Color(0xff4facfe),
                        Color(0xff00f2fe),
                      ]),
                      ColorWidget(colors: [
                        Color(0xff6a11cb),
                        Color(0xff2575fc),
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
                        Color(0xff020202),
                        Color(0xff090909),
                        Color(0xff0d0d0d),
                        Color(0xff111111),
                      ]),
                      ColorWidget(colors: [
                        Color(0xff8693AB),
                        Color(0xffBDD4E7),
                      ]),
                      ColorWidget(colors: [
                        Color(0xffF1A7F1),
                        Color(0xffFAD0C4),
                      ]),
                      ColorWidget(colors: [
                        Color(0xffF9F9F8),
                        Color(0xffE5E6E4),
                        Color(0xffECECEB),
                        Color(0xffF2F3F2),
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
                  IconButton(
                      icon: Row(
                        children: const [
                          Icon(FluentIcons.refresh),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Refresh"),
                          Spacer(),
                          Shortcuts(
                            text: "Ctrl + R",
                          )
                        ],
                      ),
                      onPressed: () {
                        readImages().then((value) {
                          setState(() {
                            Provider.of<GlobalData>(context, listen: false)
                                .changeImg(value);
                          });
                        });
                      }),
                  IconButton(
                    icon: Row(
                      children: const [
                        Icon(FluentIcons.save),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Save Image"),
                        Spacer(),
                        Shortcuts(
                          text: "Ctrl + S",
                        )
                      ],
                    ),
                    onPressed: () {
                      takePicture().whenComplete(() => showSnackbar(
                          context, const Snackbar(content: Text("Saved"))));
                    },
                  ),
                  const Spacer(),
                  Image.asset(
                    "lib/assets/logo.png",
                    width: 40,
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: RepaintBoundary(key: genKey, child: NewWidget()),
          // child: SizedBox(
          //   child: Center(
          //     child: Stack(
          //       children: [
          //         Container(
          //           decoration: BoxDecoration(
          //             gradient: LinearGradient(
          //                 colors: Provider.of<GlobalData>(context).colorList1),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.all(
          //               Provider.of<GlobalData>(context).paddingValue),
          //           child: Container(
          //             key: const Key("image"),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(
          //                 Provider.of<GlobalData>(
          //                   context,
          //                 ).borderValue,
          //               ),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black.withOpacity(0.5),
          //                   blurRadius: 10.0,
          //                   spreadRadius:
          //                       Provider.of<GlobalData>(context, listen: false)
          //                           .shadowValue,
          //                   offset: const Offset(0, 0),
          //                 ),
          //               ],
          //               image: provider.img != null
          //                   ? DecorationImage(
          //                       fit: BoxFit.fill,
          //                       image: MemoryImage(provider.img),
          //                       scale: 3,
          //                     )
          //                   : const DecorationImage(
          //                       fit: BoxFit.contain,
          //                       image: AssetImage("lib/assets/logo-text.png"),
          //                     ),
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        )
      ]),
      //
    );
  }
}

class Shortcuts extends StatelessWidget {
  const Shortcuts({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class ColorWidget extends StatefulWidget {
  final List<Color> colors;
  const ColorWidget({
    super.key,
    required this.colors,
  });

  @override
  State<ColorWidget> createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<ColorWidget> {
  @override
  Widget build(BuildContext context) {
    var tap = false;
    return GestureDetector(
      onTap: () {
        setState(() {
          tap = true;
        });
        Provider.of<GlobalData>(context, listen: false)
            .assignColor(widget.colors);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            border: tap == true
                ? Border.all(width: 3, color: Colors.black)
                : Border.all(width: 0, color: Colors.transparent),
            gradient: LinearGradient(
              colors: widget.colors,
            ),
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
