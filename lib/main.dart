import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/core/functions/initialize_services.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/state_management/bloc_observer.dart';
import 'package:electro/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'electro_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper().initPrefs();
  await initializeServices();
  await AppRoutes.init();

  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  // runApp(devicePreviewApp());
  runApp(const ElectroApp());
}
