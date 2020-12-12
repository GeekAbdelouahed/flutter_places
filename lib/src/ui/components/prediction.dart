import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class PredictionWidget extends StatelessWidget {
  final Prediction prediction;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;

  const PredictionWidget(
      {Key key, this.prediction, this.onPressed, this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onPressed,
        contentPadding: padding ?? const EdgeInsets.all(0),
        title: Text(prediction.description),
      );
}
