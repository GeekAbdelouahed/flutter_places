import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

import 'prediction_item_widget.dart';

SliverList predictionsWidget({
  List<Prediction> predictions,
  Function(Prediction) onPressedChoosePrediction,
  Widget itemLeading,
  Widget itemTrailing,
}) =>
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => GestureDetector(
          onTap: () {
            // To avoid close dialog when click on the result section
          },
          child: Material(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 72.7),
              child: Column(
                children: [
                  PredictionItemWidget(
                    prediction: predictions[index],
                    leading: itemLeading,
                    trailing: itemTrailing,
                    onPressed: () {
                      onPressedChoosePrediction?.call(
                        predictions[index],
                      );
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ),
        childCount: predictions.length,
      ),
    );
