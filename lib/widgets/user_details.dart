import 'dart:math' as math;

import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key}) : super(key: key);

  String generateRandomString(int len) {
    var r = math.Random();
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const _smallChars = 'abcdefghijklmnopqrstuvwxyz';
    final _firstChar = _chars[r.nextInt(_chars.length)];
    final _randomString = List.generate(
        len, (index) => _smallChars[r.nextInt(_smallChars.length)]).join();
    return _firstChar + _randomString;
  }

  @override
  Widget build(BuildContext context) {
    String name = generateRandomString(7);
    return GridTile(
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Color(
              (math.Random().nextDouble() * 0xFFFFFF).toInt(),
            ).withOpacity(1.0),
            child: Text(
              name[0],
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(name),
        ],
      ),
    );
  }
}
