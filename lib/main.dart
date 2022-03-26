import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import 'widgets/business_chips.dart';
import 'widgets/header.dart';
import 'widgets/user_details.dart';
import 'utils/random_gen.dart';
import 'widgets/custom_scroll_behaviour.dart';

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
          child: ListView.builder(
            controller: scrollController,
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: context.height()),
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
                      8.height,
                      BusinessChips(),
                      10.height,
                      const UserDetails(),
                      10.height,
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Header(title: "Promotions"),
                      ),
                      10.height,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
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
          label: Text(
            "Explore",
            style: TextStyle(color: Colors.blue[700], fontSize: 16),
          ),
          avatar: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.blue[700],
            size: 20,
          ),
          padding: const EdgeInsets.all(8),
          pressElevation: 4,
        ),
      ],
    );
  }
}
