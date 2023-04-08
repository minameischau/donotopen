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
              ? _buildProfile(authManager.authToken!.email)
              : FutureBuilder(
                  future: authManager.tryAutoLogin(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SplashScreen()
                        : const AuthScreen();
                  }),
        );
      },
    );
  }

  Widget _buildProfile(auth) {
    return Consumer<AuthManager>(
      builder: (context, user, child) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1.1,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    // margin: const EdgeInsets.only(left: 20, bottom: 20),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://res.cloudinary.com/dvbzja2gq/image/upload/v1678609678/motorcycle/avt/avt1_pzd4ef.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Text(
                  auth,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 370,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: auth == 'admin@gmail.com' ||
                                auth == 'panow@gmail.com'
                            ? Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.add_circle_outline_rounded,
                                    size: 18,
                                    color: red,
                                  ),
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ProductList()));
                                  },
                                  title: const Text('Quản lý sản phẩm'),
                                ),
                              )
                            : Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.shopping_bag,
                                    size: 18,
                                    color: red,
                                  ),
                                  title: const Text('Đơn hàng của bạn'),
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             OrderScreen()));
                                  },
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: auth == 'ngoctran080901@gmail.com' ||
                                auth == 'kimlinh@gmail.com'
                            ? Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.shopping_bag,
                                    size: 18,
                                    color: green,
                                  ),
                                  title: const Text('Quản lý đơn hàng'),
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             OrderScreen()));
                                  },
                                ),
                              )
                            : Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: ListTile(
                                    leading: const Icon(
                                      Icons.remove_red_eye_sharp,
                                      size: 18,
                                      color: green,
                                    ),
                                    title: const Text('Sản phẩm đã xem'),
                                    onTap: () {},
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: const Icon(
                              Icons.question_answer,
                              size: 18,
                              color: green,
                            ),
                            title: const Text('Trợ giúp'),
                            onTap: () {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: const Icon(
                              Icons.settings,
                              size: 18,
                              color: Color.fromARGB(255, 253, 204, 5),
                            ),
                            title: const Text('Cài đặt tài khoản'),
                            onTap: () {},
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          leading: const Icon(
                            Icons.exit_to_app,
                            size: 18,
                            color: Color.fromARGB(255, 33, 51, 243),
                          ),
                          title: const Text('Log out'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AuthScreen()));

                            context.read<AuthManager>().logout();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
