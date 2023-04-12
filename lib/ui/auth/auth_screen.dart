import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:panow/ui/control_screen.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            color: grey,
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Flexible(
                    child: AppBanner(),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 2,
                    child: AuthCard(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'OR',
                    style: TextStyle(color: textCorlor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildSocialIcon(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/google.svg',
            height: 150,
            width: 150,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/facebook.svg',
            height: 150,
            width: 150,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/github.svg',
            height: 150,
            width: 150,
          ),
        ),
      ],
    );
  }
}
