import 'package:flutter/material.dart';
import 'package:gpay_ui_rep/widgets/user_details.dart';

import 'package:snapping_sheet/snapping_sheet.dart';

void main() {
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
          )),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  Widget _buildBox() => const SizedBox(
        height: 10,
      );

  final _snapController = SnappingSheetController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: SnappingSheet(
        snappingPositions: const [
          SnappingPosition.factor(positionFactor: 1),
          SnappingPosition.factor(positionFactor: .7),
          SnappingPosition.factor(positionFactor: .09)
        ],
        initialSnappingPosition:
            const SnappingPosition.factor(positionFactor: .7),
        controller: _snapController,
        child: Padding(
          padding: MediaQuery.of(context).viewPadding,
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                ActionChip(
                  backgroundColor: Colors.white,
                  elevation: 5,
                  onPressed: () {},
                  label: const Text(" Scan any QR"),
                  avatar: const Icon(Icons.center_focus_weak_rounded),
                ),
              ],
            ),
          ),
        ),
        sheetBelow: SnappingSheetContent(
          draggable: true,
          child: ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    _buildBox(),
                    Container(
                      height: 3,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    _buildBox(),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "People",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    _buildBox(),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return const UserDetails();
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
