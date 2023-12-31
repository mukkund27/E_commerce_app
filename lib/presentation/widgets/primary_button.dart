import 'package:e_com/core/ui.dart';
import 'package:flutter/cupertino.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;
  const PrimaryButton({Key? key, required this.text, this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        color:color ?? AppColors.accent,
        onPressed:onPressed,
        child:   Text(text),
      ),
    );
  }
}
