import 'package:flutter/material.dart';

import '../../utils/extensions.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width * .3,
        child: Image.asset(
          context.isDarkMode
              ? 'packages/flutter_places/assets/google_dark.png'
              : 'packages/flutter_places/assets/google_light.png',
        ),
      );
}
