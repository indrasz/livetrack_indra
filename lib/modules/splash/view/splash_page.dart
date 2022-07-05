import 'package:flutter/material.dart';

import 'package:livetrack_indra/gen/assets.gen.dart';
import 'package:livetrack_indra/gen/colors.gen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: [
        Positioned(
          right: 32,
          top: 16,
          child: Assets.images.logoTranstrack.image(width: 180),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(),
              const Text(
                'RegisT Operational',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorName.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorName.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
}
