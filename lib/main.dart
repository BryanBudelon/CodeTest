import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const actualText = "Lorem";

    //Set a textStyle to use in TextPainter
    const textStyle = TextStyle(fontSize: 13, color: Colors.white);

    //Defined a TextPainter with our text and parameters to then be able to calculate lines.
    final textPainter = TextPainter(
      text: const TextSpan(text: actualText, style: textStyle),
      maxLines: 3,
      textDirection: TextDirection.ltr,
    )..layout(
        maxWidth: 198,
      );

    //Here we are getting the LineMetrics to then iterate the List, attempting to calculate the current height based on text.
    final line = textPainter.computeLineMetrics();
    double height = line.fold(0, (total, current) => (total + current.height));

    //And here just some basic conditions to resize height and width based on computeLineMetrics return
    height = height < 72
        ? 72
        : height > 72
            ? 90
            : height;

    final width = textPainter.width > 90
        ? textPainter.width > 198
            ? 198
            : textPainter.width
        : 72;

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: 88.0 - height,
            left: 4.0,
          ),
          padding: const EdgeInsets.all(8.0),
          constraints: BoxConstraints(maxWidth: width + 2), // For border
          height: height,

          decoration: BoxDecoration(
            color: Colors.greenAccent.shade700,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 4.0),
                constraints: const BoxConstraints(maxWidth: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text(
                        "AUTHOR",
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(fontSize: 9, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                actualText,
                style: textStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
