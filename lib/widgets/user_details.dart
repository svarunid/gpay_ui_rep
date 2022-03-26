import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';

import 'user.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final List<User> expandedUsers = List.generate(18, (index) => const User());

  List<User> get initalUsers => expandedUsers.getRange(0, 7).toList();

  Widget get expansionWidget {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.black38,
            child: Icon(
              _isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
            ),
          ),
        ),
        8.height,
        Text(_isExpanded ? "Less" : "More")
      ],
    );
  }

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: 200.milliseconds,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        children: _isExpanded
            ? [...expandedUsers, expansionWidget]
            : [...initalUsers, expansionWidget],
      ),
    );
  }
}
