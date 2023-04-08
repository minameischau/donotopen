import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:panow/models/http_exception.dart';
import 'package:panow/ui/control_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool passenable = true;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();
  bool hiddenPassword = true, errorLogin = false;
  // String username = '', password = '';
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      await context.read<AuthManager>().login(
            _authData['email']!,
            _authData['password']!,
          );
    } catch (error) {
      showErrorDialog(
          context,
          (error is HttpException)
              ? error.toString()
              : 'Quá trình xác thực thất bại');
    }
    _isSubmitting.value = false;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  thirthCorlor.withOpacity(0.5),
                  secondCorlor.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Flexible(
                    child: AppBanner(),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: deviceSize.height,
                        width: deviceSize.width * 0.75,
                        child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  _buildEmailField(),
                                  _buildPasswordField(),
                                  _buildForgetPassword(),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: _isSubmitting,
                                    builder: (context, isSubmitting, child) {
                                      if (isSubmitting) {
                                        return const CircularProgressIndicator();
                                      }
                                      return _buildSubmitButton();
                                    },
                                  ),
                                  _buildAuthModeSwitchButton(),
                                  _buildSocialIcon(),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Nhập email',
        prefixIcon: Icon(Icons.email_outlined),
        labelText: 'E-Mail',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Email không hợp lệ.';
        }
        return null;
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Nhập mật khẩu',
        suffix: IconButton(
          onPressed: () {
            setState(() {
              if (passenable) {
                passenable = false;
              } else {
                passenable = true;
              }
            });
          },
          icon: FaIcon(
            passenable == true
                ? FontAwesomeIcons.eye
                : FontAwesomeIcons.eyeSlash,
            size: 15,
          ),
        ),
        labelText: 'Mật khẩu',
        prefixIcon: const Icon(Icons.lock_outline_rounded),
      ),
      obscureText: passenable,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.length <= 5) {
          return 'Mật khẩu quá ngắn';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _buildForgetPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Quên mật khẩu?',
            style: TextStyle(
              color: blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          height: 1.5,
          color: Theme.of(context).primaryTextTheme.titleLarge?.color,
        ),
      ),
      child: const Text('ĐĂNG NHẬP'),
    );
  }

  Widget _buildAuthModeSwitchButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text.rich(
            TextSpan(
              text: "Chưa có tài khoản? ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "Tạo tài khoản mới",
                  style: const TextStyle(
                    color: blue,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                ),
              ],
            ),
          ),
        ),
        const Text(
          'Hoặc',
          style: TextStyle(color: black),
        ),
      ],
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
