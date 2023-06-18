import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const LinkButton({Key? key, required this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed:onPressed,
      child: Text(text),
    );
  }
}
