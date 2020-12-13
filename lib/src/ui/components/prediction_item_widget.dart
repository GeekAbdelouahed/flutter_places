import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class PredictionItemWidget extends StatelessWidget {
  final Prediction prediction;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final Widget leading;
  final Widget trailing;

  const PredictionItemWidget({
    Key key,
    this.prediction,
    this.onPressed,
    this.padding,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onPressed,
        contentPadding: padding ?? const EdgeInsetsDirectional.only(end: 16),
        leading: leading,
        title: Text(prediction.description),
        trailing: trailing,
      );
}
