import 'package:dating_app/pages/home_page.dart';
import 'package:dating_app/pages/theme/theme.dart';
import 'package:flutter/material.dart';

typedef PressCallback = void Function();

class SigninButton extends StatelessWidget {
  const SigninButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final PressCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cornerRadius),
          gradient: const LinearGradient(
            colors: buttonBackground,
          )),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
