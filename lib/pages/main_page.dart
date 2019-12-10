import 'package:dating_app/resources/buttons/signin_button.dart';
import 'package:dating_app/resources/controllers/login_character.dart';
import 'package:dating_app/resources/controllers/tracking_text_input.dart';
import 'package:dating_app/resources/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../resources/controllers/character_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  final CharacterController _characterController =
      CharacterController(projectGaze: LoginCharacter.projectGaze);

  String _password;
  @override
  Widget build(BuildContext context) {
    final EdgeInsets devicePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(93, 142, 155, 1.0),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [1.0, 10.0],
                    colors: background,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: devicePadding.top + 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    LoginCharacter(controller: _characterController),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(cornerRadius))),
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TrackingTextInput(
                                label: 'Email',
                                hint: 'Whats your email address?',
                                onCaretMoved: (Offset caret) {
                                  _characterController.lookAt(caret);
                                },
                              ),
                              TrackingTextInput(
                                label: 'Password',
                                hint: 'Try bears...',
                                isObscured: true,
                                onCaretMoved: (Offset caret) {
                                  _characterController.coverEyes(caret != null);
                                  _characterController.lookAt(null);
                                },
                                onTextChanged: (String value) {
                                  _password = value;
                                },
                              ),
                              SigninButton(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                onPressed: _login,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> checkCredentials() async {
    return _password == 'bears';
  }

  Future<void> _login() async {
    // Clear focus from text fields.
    FocusScope.of(context).requestFocus(FocusNode());
    // Bring hands down
    _characterController.coverEyes(false);

    // Check password
    final bool valid = await checkCredentials();
    if (valid) {
      _characterController.rejoice();
    } else {
      _characterController.lament();
    }
  }
}
