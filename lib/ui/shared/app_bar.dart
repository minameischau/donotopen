import 'package:flutter/material.dart';

import 'package:panow/ui/control_screen.dart';

class AppBarOrigin extends StatelessWidget {
  final IconButton leading;
  final String title;
  final Widget action;
  const AppBarOrigin({
    super.key,
    required this.title,
    required this.leading,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 18, color: textCorlor, fontWeight: FontWeight.w500),
      ),
      actions: [action],
      backgroundColor: primaryCorlor,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowCorlor, // màu của đổ bóng
              spreadRadius: 5, // bán kính của đổ bóng
              blurRadius: 7, // độ mờ của đổ bóng
              offset: Offset(0, 3), // hướng của đổ bóng
            ),
          ],
        ),
      ),
    );
  }
}
