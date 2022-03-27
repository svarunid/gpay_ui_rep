import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';

import 'custom_scroll_behaviour.dart';

class BusinessChips extends StatelessWidget {
  const BusinessChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScrollBehaviour(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            chip("Bills", Icons.shopping_bag_outlined),
            15.width,
            chip("Recahrge", Icons.phone_android_rounded),
            15.width,
            chip("Spots", Icons.brightness_high_outlined),
            15.width,
            chip("Donations", Icons.favorite_outline_rounded),
          ],
        ),
      ),
    );
  }

  ActionChip chip(String label, IconData icon) {
    return ActionChip(
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      onPressed: () {},
      labelPadding: const EdgeInsets.all(6),
      avatar: Icon(icon),
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: Colors.black12, width: 1),
      pressElevation: 0,
    );
  }
}
