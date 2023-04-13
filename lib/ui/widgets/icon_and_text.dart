import 'package:flutter/material.dart';
import '../../ui/widgets/small_text.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  double size;
  final Color iconColor;
  IconAndText(
      {Key? key,
      required this.icon,
      required this.size,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: size,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
          size: 16,
        )
      ],
    );
  }
}
