import 'dart:convert';

import 'package:dating_app/models/user.dart';

import 'package:dating_app/pages/details_page.dart';
import 'package:dating_app/resources/animation/screen_animation.dart';
import 'package:dating_app/resources/buttons/user_buttons.dart';

import 'package:dating_app/resources/theme/theme.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Future<User> _user;
  Animation _pictAnimation;
  AnimationController _picAnimationController;

  @override
  void initState() {
    super.initState();
    _user = _generateUser();

    _picAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _pictAnimation = Tween(begin: 300.0, end: 330.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _picAnimationController));

    _picAnimationController.addStatusListener(
      (AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _picAnimationController.repeat();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _picAnimationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Almost Tinder'),
        ),
        body: Center(
          child: FutureBuilder<User>(
              future: _user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        AnimatedBuilder(
                          animation: _picAnimationController,
                          builder: (context, child) => Hero(
                            tag: 'avatar',
                            child: Image.network(
                              snapshot.data.image,
                              fit: BoxFit.fill,
                              height: _pictAnimation.value,
                              width: _pictAnimation.value,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                            snapshot.data.name,
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                        UserButtons(
                          onReload: () {
                            setState(
                              () {
                                _user = _generateUser();
                                _picAnimationController.forward();
                              },
                            );
                          },
                          onNext: () {
                            Navigator.of(context).push<void>(
                              SlideRightRoute(
                                widget: DetailsPage(user: snapshot.data),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text(
                      'Something is wrong. Check your internet connection. :-(');
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  Future<User> _generateUser() async {
    final uri = Uri.https('randomuser.me', '/api/1.3');
    final response = await http.get(uri);
    return compute(_parseUser, response.body);
  }

  static User _parseUser(String response) {
    final Map<String, dynamic> parsed = json.decode(response);
    return User.fromRandomUserResponse(parsed);
  }
}
