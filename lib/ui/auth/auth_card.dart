import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panow/models/http_exception.dart';

import 'package:panow/ui/control_screen.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  bool passenable = true;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        await context.read<AuthManager>().login(
              _authData['email']!,
              _authData['password']!,
            );
      } else {
        // Sign user up
        await context.read<AuthManager>().signup(
              _authData['email']!,
              _authData['password']!,
            );
      }
    } catch (error) {
      showErrorDialog(
          context,
          (error is HttpException)
              ? error.toString()
              : 'Authentication failed');
    }

    _isSubmitting.value = false;
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Material(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: deviceSize.width * 0.9,
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: <Widget>[
                  _buildEmailField(),
                  _buildPasswordField(),
                  if (_authMode == AuthMode.signup)
                    _buildPasswordConfirmField(),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isSubmitting,
                    builder: (context, isSubmitting, child) {
                      if (isSubmitting) {
                        return const CircularProgressIndicator();
                      }
                      return _buildSubmitButton();
                    },
                  ),
                  SizedBox(height: 5),
                  _buildAuthModeSwitchButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthModeSwitchButton() {
    return TextButton(
      onPressed: _switchAuthMode,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: const TextStyle(
          // color: Theme.of(context).primaryColor,
          color: textCorlor,
        ),
      ),
      child: RichText(
        text: TextSpan(
          // style: TextStyle(fontSize: 14),
          children: <TextSpan>[
            TextSpan(
              text:
                  '${_authMode == AuthMode.login ? 'New to Panow? ' : 'Already have an account? '} ',
              style: const TextStyle(
                color: textCorlor,
                fontFamily: 'SFCompactRounded',
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text:
                  '${_authMode == AuthMode.login ? 'Create here' : 'Log in'} ',
              style: TextStyle(color: blue),
            ),
          ],
        ),
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        textStyle: TextStyle(
          fontFamily: 'SFCompactRounded',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          height: 1.5,
          color: Theme.of(context).primaryTextTheme.titleLarge?.color,
        ),
      ),
      child: Text(_authMode == AuthMode.login ? 'Log in' : 'Sign up'),
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      obscureText: passenable,
      cursorHeight: 10,
      enabled: _authMode == AuthMode.signup,
      decoration: InputDecoration(
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
              size: 16,
            )),
        labelText: 'Comfirm password',
        prefixIcon: const Icon(Icons.key_rounded),
      ),
      validator: _authMode == AuthMode.signup
          ? (value) {
              if (value != _passwordController.text) {
                return 'Password does not match';
              }
              return null;
            }
          : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
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
            size: 16,
          ),
        ),
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline_rounded),
      ),
      obscureText: passenable,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.length <= 5) {
          return 'Password is too short';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email_rounded),
        labelText: 'Email',
      ),
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Invalid email';
        }
        return null;
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
    );
  }
}
