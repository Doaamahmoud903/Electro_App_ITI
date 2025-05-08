import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../electro_app.dart';

Widget devicePreviewApp() => DevicePreview(
  enabled: !kReleaseMode,
  builder: (context) => const ElectroApp(), // Wrap your app
);
