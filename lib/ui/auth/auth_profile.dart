import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:panow/ui/control_screen.dart';

class AuthProfile extends StatefulWidget {
  const AuthProfile({super.key});

  @override
  State<AuthProfile> createState() => _AuthProfileState();
}

class _AuthProfileState extends State<AuthProfile> {
  @override
  Widget build(BuildContext context) {
    ChangeNotifierProvider(create: (context) => AuthManager());
    return Consumer<AuthManager>(
      builder: (context, authManager, child) {
        return Material(
          child: authManager.isAuth
              ? _buildProfile(authManager.authToken!.email, context, child)
              : FutureBuilder(
                  future: authManager.tryAutoLogin(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SplashScreen()
                        : AuthScreen();
                  }),
        );
      },
    );
  }

  Widget _buildProfile(email, context, child) {
    final deviceSize = MediaQuery.of(context).size;
    return Consumer<AuthManager>(
      builder: (context, user, child) {
        return Scaffold(
          appBar: AppBar(
              title: const Center(
            child: Text(
              'Thông tin tài khoản',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          body: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: deviceSize.width * 0.9,
                child: Column(
                  children: [
                    _buildAvt(email),
                    _buildListProfile(email),
                    const SizedBox(height: 20),
                    _buildButtonLogOut(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvt(email) {
    return Column(
      children: [
        Center(
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              image: DecorationImage(
                  image: NetworkImage(
                      'https://res.cloudinary.com/dvbzja2gq/image/upload/v1678609678/motorcycle/avt/avt1_pzd4ef.png'),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          email,
          style: const TextStyle(
              // fontFamily: 'SFCompactRounded',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textCorlor),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildListProfile(email) {
    return Material(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProductsManager(email, context),
              const SizedBox(height: 5),
              _buildOrdersManager(email, context),
              const SizedBox(height: 5),
              _buildSetting(),
              const SizedBox(height: 5),
              _buildIntroduction(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsManager(email, context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: email == 'admin@gmail.com' || email == 'panow@gmail.com'
          ? GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ProductList()));
              },
              child: Row(
                children: [
                  const Icon(Icons.edit, size: 20, color: primaryCorlor),
                  const SizedBox(width: 10),
                  const Text('Quản lý sản phẩm',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.keyboard_arrow_right_rounded,
                          size: 20, color: textCorlor))
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ProductList()));
              },
              child: Row(
                children: [
                  const Icon(Icons.favorite_border_rounded,
                      size: 20, color: primaryCorlor),
                  const SizedBox(width: 10),
                  const Text('Sản phẩm yêu thích',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.keyboard_arrow_right_rounded,
                          size: 20, color: textCorlor))
                ],
              ),
            ),
    );
  }

  Widget _buildOrdersManager(email, context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: email == 'admin@gmail.com' || email == 'panow@gmail.com'
          ? GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ProductList()));
              },
              child: Row(
                children: [
                  const Icon(Icons.shopping_bag_outlined,
                      size: 20, color: primaryCorlor),
                  const SizedBox(width: 10),
                  const Text('Quản lý đơn hàng',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.keyboard_arrow_right_rounded,
                          size: 20, color: textCorlor))
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ProductList()));
              },
              child: Row(
                children: [
                  const Icon(Icons.shopping_bag_outlined,
                      size: 20, color: primaryCorlor),
                  const SizedBox(width: 10),
                  const Text('Đơn hàng của bạn',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.keyboard_arrow_right_rounded,
                          size: 20, color: textCorlor))
                ],
              ),
            ),
    );
  }

  Widget _buildSetting() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ProductList()));
        },
        child: Row(
          children: [
            const Icon(Icons.settings, size: 20, color: primaryCorlor),
            const SizedBox(width: 10),
            const Text('Cài đặt',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Spacer(),
            Container(
                padding: const EdgeInsets.all(3),
                child: const Icon(Icons.keyboard_arrow_right_rounded,
                    size: 20, color: textCorlor))
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ProductList()));
        },
        child: Row(
          children: [
            const Icon(Icons.info_outline_rounded,
                size: 20, color: primaryCorlor),
            const SizedBox(width: 10),
            const Text('Giới thiệu',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Spacer(),
            Container(
                padding: const EdgeInsets.all(3),
                child: const Icon(Icons.keyboard_arrow_right_rounded,
                    size: 20, color: textCorlor))
          ],
        ),
      ),
    );
  }

  Widget _buildButtonLogOut() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnBoardScreen()),
        );
        context.read<AuthManager>().logout();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // rounded corners
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // button padding
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold, // text font weight
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.logout), // add an icon
          SizedBox(width: 10), // add spacing between icon and text
          Text('Đăng xuất'), // add text
        ],
      ),
    );
  }
}
