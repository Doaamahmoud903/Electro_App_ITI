import 'package:electro/core/cach_helper/cach_helper.dart';

Future<void> initializeCache() async {
  await CacheHelper().initPrefs();
}
