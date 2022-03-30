import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nb_utils/nb_utils.dart';

enum LockState { login, setPin, changePin }

class LockScreen extends HookWidget {
  final String title;
  final LockState state;
  final String passcode;

  LockScreen({
    Key? key,
    this.title = "Enter Your PIN",
    this.state = LockState.login,
    this.passcode = "",
  }) : super(key: key);
  final IconData iconEmpty = Icons.circle_outlined;

  final IconData iconFilled = Icons.circle_rounded;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> pin = useState<String>("");
    AnimationController animationController =
        useAnimationController(duration: 750.milliseconds)..repeat();
    int animationValue = useAnimation(IntTween(begin: 1, end: 4).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear)));

    void logIn(number) {
      if (pin.value.length < 4) {
        pin.value += number;
      } else if (pin.value.length == 4) {
        animationController.forward();
      }
    }

    Widget keyNum(number) {
      return InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          if (state == LockState.login) {
            if (passcode.isNotEmpty) {
              if (passcode == pin) {}
            } else {
              logIn(number);
            }
          } else if (state == LockState.changePin) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => LockScreen(passcode: pin.value)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          child: Text(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      );
    }

    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            10.height,
            const Text("xyz@gmail.com"),
            15.height,
            pin.value.length >= 4
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle_sharp,
                          color: animationValue == 1
                              ? Colors.grey
                              : Colors.grey[400]),
                      5.width,
                      Icon(Icons.circle_sharp,
                          color: animationValue == 2
                              ? Colors.grey
                              : Colors.grey[400]),
                      5.width,
                      Icon(Icons.circle_sharp,
                          color: animationValue == 3
                              ? Colors.grey
                              : Colors.grey[400]),
                      5.width,
                      Icon(Icons.circle_sharp,
                          color: animationValue == 4
                              ? Colors.grey
                              : Colors.grey[400]),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(pin.value.isNotEmpty ? iconFilled : iconEmpty),
                      6.width,
                      Icon(pin.value.length >= 2 ? iconFilled : iconEmpty),
                      6.width,
                      Icon(pin.value.length >= 3 ? iconFilled : iconEmpty),
                      6.width,
                      Icon(pin.value.length >= 4 ? iconFilled : iconEmpty),
                    ],
                  ),
            const Spacer(),
            SizedBox(
              height: 275,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      keyNum("1"),
                      keyNum("2"),
                      keyNum("3"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      keyNum("4"),
                      keyNum("5"),
                      keyNum("6"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      keyNum("7"),
                      keyNum("8"),
                      keyNum("9"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      50.width,
                      keyNum("0"),
                      IconButton(
                        onPressed: () {
                          if (pin.value.isNotEmpty && pin.value.length < 4) {
                            pin.value =
                                pin.value.substring(0, pin.value.length - 1);
                          }
                        },
                        icon: const Icon(Icons.backspace_outlined),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
