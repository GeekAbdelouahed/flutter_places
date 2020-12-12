import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

import 'prediction_widget.dart';

SliverList predictionsWidget({
  List<Prediction> predictions,
  Function(Prediction) onPressedChoosePrediction,
}) =>
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => GestureDetector(
          onTap: () {
            // To avoid close dialog when click on the result section
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsetsDirectional.only(start: 72.7),
            child: Column(
              children: [
                if (index > 0) const Divider(),
                PredictionWidget(
                  prediction: predictions[index],
                  onPressed: () {
                    onPressedChoosePrediction?.call(
                      predictions[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        childCount: predictions.length,
      ),
    );
