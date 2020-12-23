# Flutter Places Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_places/flutter_places.dart';

String apiKey = "API_KEY";

void main() async {
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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Place _selectedPlace;

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
              Text(
                _selectedPlace?.prediction?.description ?? 'Place name',
              ),
              const SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () async {
                  final place = await FlutterPlaces.show(
                    context: context,
                    apiKey: apiKey,
                  );

                  setState(() {
                    _selectedPlace = place;
                  });
                },
                child: Text('Fullscreen'),
              ),
              const SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () async {
                  final place = await FlutterPlaces.show(
                    context: context,
                    apiKey: apiKey,
                    modeType: ModeType.OVERLAY,
                  );

                  setState(() {
                    _selectedPlace = place;
                  });
                },
                child: Text('Overlay'),
              ),
              const SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () async {
                  final place = await FlutterPlaces.show(
                    context: context,
                    apiKey: apiKey,
                    modeType: ModeType.BOTTOM_SHEET,
                  );

                  setState(() {
                    _selectedPlace = place;
                  });
                },
                child: Text('Bottomsheet'),
              ),
            ],
          ),
        ),
      );
}

```
