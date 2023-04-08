import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:panow/ui/control_screen.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SvgPicture.asset(
        "assets/panow.svg",
        color: primaryCorlor,
        height: 250,
      ),
    );
  }
}
