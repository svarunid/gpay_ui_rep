import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gpay_ui_rep/screens/lock_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import 'widgets/business_chips.dart';
import 'widgets/header.dart';
import 'widgets/user_details.dart';
import 'utils/random_gen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gpay',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.light(
          secondary: Colors.blue[700]!,
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends HookWidget {
  HomePage({Key? key}) : super(key: key);

  final _snapController = SnappingSheetController();

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = useScrollController();
    AnimationController animationController =
        useAnimationController(duration: 100.milliseconds);
    Animation<Offset> animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 1.5),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.linear),
    );

    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: SnappingSheet(
        snappingPositions: [
          SnappingPosition.factor(
            positionFactor: 1,
            snappingDuration: 100.milliseconds,
          ),
          SnappingPosition.factor(
            positionFactor: .7,
            snappingDuration: 100.milliseconds,
          ),
          SnappingPosition.factor(
            positionFactor: .09,
            snappingDuration: 100.milliseconds,
          )
        ],
        onSnapCompleted: (sheetPosition, snapPosition) {
          if (sheetPosition.relativeToSheetHeight == 0.09) {
            animationController.forward();
          }
          if (sheetPosition.relativeToSheetHeight <= 0.7 &&
              animationController.isCompleted) {
            animationController.reverse();
          }
        },
        initialSnappingPosition:
            const SnappingPosition.factor(positionFactor: .7),
        controller: _snapController,
        child: Padding(
          padding: MediaQuery.of(context).viewPadding,
          child: Align(
            alignment: Alignment.topCenter,
            child: _pageHeader(),
          ),
        ),
        sheetBelow: SnappingSheetContent(
          childScrollController: scrollController,
          draggable: true,
          child: Stack(
            children: [
              NotificationListener<UserScrollNotification>(
                onNotification: ((notification) {
                  if (notification.direction == ScrollDirection.forward &&
                      animationController.isCompleted) {
                    animationController.reverse();
                  }
                  return false;
                }),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (notification) {
                    if (notification.leading) {
                      notification.disallowIndicator();
                    }
                    if (!notification.leading) {
                      animationController.forward();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: context.height()),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              10.height,
                              _handle(),
                              10.height,
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Header(title: "People"),
                              ),
                              10.height,
                              const UserDetails(),
                              10.height,
                              businessHeader(),
                              10.height,
                              const BusinessChips(),
                              15.height,
                              const UserDetails(),
                              10.height,
                              15.height,
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => LockScreen(),
                                    ),
                                  );
                                },
                                child: const Text("Set PIN"),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  )),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueAccent[400]),
                                ),
                              ),
                              10.height,
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => LockScreen(),
                                    ),
                                  );
                                },
                                child: const Text("Change PIN"),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  )),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueAccent[400]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SlideTransition(
        position: animation,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blueAccent[400],
          onPressed: () {},
          label: const Text(
            "New Payment",
          ),
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add_rounded),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _handle() {
    return Container(
      height: 3,
      width: 25,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }

  Widget _pageHeader() {
    return Row(
      children: [
        10.width,
        ActionChip(
          backgroundColor: Colors.white,
          elevation: 5,
          onPressed: () {},
          label: const Text(" Scan any QR"),
          avatar: const Icon(Icons.center_focus_weak_rounded),
        ),
        const Spacer(),
        CircleAvatar(
          backgroundColor: getRandomColor(),
          child: Text(
            getRandomChar(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        10.width,
      ],
    );
  }

  Widget businessHeader() {
    return Row(
      children: [
        const Header(title: "Bussiness & Bills"),
        const Spacer(),
        ActionChip(
          backgroundColor: Colors.blue[50],
          onPressed: () {},
          label: const Text(
            "Explore",
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
          avatar: const Icon(
            Icons.shopping_bag_outlined,
            color: Colors.blue,
            size: 20,
          ),
          padding: const EdgeInsets.all(8),
          pressElevation: 4,
        ),
      ],
    );
  }
}
