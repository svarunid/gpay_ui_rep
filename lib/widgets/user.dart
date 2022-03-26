import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';

import '../utils/random_gen.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = getRandomString(7);
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: getRandomColor(),
          child: Text(
            name[0],
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        8.height,
        Text(name),
      ],
    );
  }
}
