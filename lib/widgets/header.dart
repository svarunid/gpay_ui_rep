import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    ).paddingSymmetric(vertical: 10);
  }
}