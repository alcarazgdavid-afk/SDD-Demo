import 'package:flutter/material.dart';

import 'screens/plant_dashboard_screen.dart';
import 'theme/app_theme.dart';

class GearVisionApp extends StatelessWidget {
  const GearVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GearVision',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PlantDashboardScreen(),
    );
  }
}
