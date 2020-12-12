import 'package:flutter/material.dart';

import '../../utils/extensions.dart';

class LogoWidget extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;

  const LogoWidget({
    Key key,
    this.height,
    this.width,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width ?? MediaQuery.of(context).size.width * .3,
        child: child ??
            Image.asset(
              context.isDarkMode
                  ? 'packages/flutter_places/assets/google_light.png'
                  : 'packages/flutter_places/assets/google_dark.png',
            ),
      );
}
