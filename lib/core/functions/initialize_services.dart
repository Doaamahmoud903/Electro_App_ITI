// ignore_for_file: avoid_print
import 'package:electro/core/di/di.dart';
import 'package:electro/core/functions/initialize_cache.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

Future<void> initializeServices() async {
  // try {
  //   await initializeFirebase();
  //   print('Firebase initialized successfully');
  // } catch (e){
  //   print('Error initializing Firebase: $e');
  // }
  try {
    await Hive.initFlutter();
    await Hive.openBox('complexDataBox');
    print('Hive initialized and box opend successfully');
  } catch (e) {
    print('Error initializing Hive: $e');
  }

  try {
    await initializeCache();
    print('Cache initialized successfully');
  } catch (e) {
    print('Error initializing Cache: $e');
  }

  // try {
  //   await fetchAndStoreFCMToken();
  //   print('FCM Token fetched and stored successfully');
  // } catch (e){
  //   print('Error fetching and storing FCM Token: $e');
  // }

  // try {
  //   // await FirebaseApi().initNotfication();
  //   await NotificationService.instance.initialize();
  //   print('Firebase notification initialized successfully');
  // } catch (e){
  //   print('Error initializing Firebase notifications: $e');
  // }

  try {
    await AppRoutes.init();
    print('AppRoutes initialized successfully');
  } catch (e) {
    print('Error initializing AppRoutes: $e');
  }

  // try {
  //   await PdfGeneratorService.init();
  //   print('Pdf Generator Service initialized successfully');
  // } catch (e){
  //   print('Error initializing Pdf Generator Service: $e');
  // }

  setupServiceLocator();
}
