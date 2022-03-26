import 'dart:math' as math;

import 'package:flutter/widgets.dart';

String getRandomString(int len) {
  var r = math.Random();
  const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const _smallChars = 'abcdefghijklmnopqrstuvwxyz';
  final _firstChar = _chars[r.nextInt(_chars.length)];
  final _randomString =
      List.generate(len, (index) => _smallChars[r.nextInt(_smallChars.length)])
          .join();
  return len>1 ? _firstChar + _randomString : _firstChar;
}

Color getRandomColor() => Color(
      (math.Random().nextDouble() * 0xFFFFFF).toInt(),
    ).withOpacity(1.0);

String getRandomChar() {
  return getRandomString(1);
}
