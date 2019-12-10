import 'package:dating_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:location_permissions/location_permissions.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key key, this.user}) : super(key: key);
  final User user;
  @override
  DetailsPageState createState() => DetailsPageState(user);
}

class DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  DetailsPageState(this.user);
  Animation<double> _opacity;
  AnimationController _opacityController;
  final User user;

  @override
  void initState() {
    super.initState();
    _opacityController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _opacity =
        CurvedAnimation(parent: _opacityController, curve: Curves.fastOutSlowIn)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _opacityController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _opacityController.forward();
            }
          });
    _opacityController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _opacityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeTransition(
                child: Hero(
                  tag: 'avatar',
                  child: Image.network(
                    user.image,
                    fit: BoxFit.fill,
                    height: 400,
                    width: 400,
                  ),
                ),
                opacity: _opacity),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<LatLng>(
                future: _getCoordinates(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final km = Distance().as(LengthUnit.Kilometer,
                        snapshot.data, LatLng(user.latitude, user.longitude));
                    return Text(
                      '${user.name} is $km km away from you!',
                      style: Theme.of(context).textTheme.headline,
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Please turn on the geolocation',
                      style: Theme.of(context).textTheme.headline,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<LatLng> _getCoordinates() async {
    final permission = LocationPermissions();
    await permission.requestPermissions();

    final geolocator = Geolocator();
    final position = await geolocator.getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }
}
