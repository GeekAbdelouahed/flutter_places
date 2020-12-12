import 'package:flutter/material.dart';
import 'package:flutter_places/flutter_places.dart';

import 'environment.dart';

String API_KEY;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  API_KEY = await Environment.loadKeys();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Flutter places'),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () async {
                  final place = await FlutterPlaces.show(
                    context: context,
                    apiKey: API_KEY,
                  );
                  print(
                      'palce name: ${place?.placeDetails?.geometry?.location?.lat}');
                },
                child: Text('Fullscreen'),
              ),
              const SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  FlutterPlaces.show(
                    context: context,
                    apiKey: API_KEY,
                    modeType: ModeType.OVERLAY,
                  );
                },
                child: Text('Overlay'),
              ),
              const SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  FlutterPlaces.show(
                    context: context,
                    apiKey: API_KEY,
                    modeType: ModeType.BOTTOM_SHEET,
                  );
                },
                child: Text('Bottomsheet'),
              ),
            ],
          ),
        ),
      );
}
