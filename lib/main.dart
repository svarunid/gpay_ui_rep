import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gpay',
      theme: ThemeData(
          primaryColor: Colors.blue,
          colorScheme: ColorScheme.light(
            secondary: Colors.blue[700]!,
          )),
      home: HomePage(),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimationController _bottomSheetController = useAnimationController();
    return Scaffold(
      body: Container(),
      bottomSheet: BottomSheet(
        elevation: 15,
        onClosing: () {},
        builder: (context) => SizedBox(
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 2,
                    width: 25,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: FloatingActionButton.extended(
                  onPressed: (() {}),
                  label: Text("New Payment"),
                  icon: Icon(Icons.add_rounded),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ]),
          height: MediaQuery.of(context).size.height * .75,
        ),
        enableDrag: true,
        animationController: _bottomSheetController,
      ),
    );
  }
}
