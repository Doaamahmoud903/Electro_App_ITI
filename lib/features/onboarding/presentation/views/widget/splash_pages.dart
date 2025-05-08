import 'dart:convert';

import 'package:electro/core/cach_helper/cach_helper.dart';
import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/routes/routes.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:electro/features/auth/data/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPages extends StatefulWidget {
  const SplashPages({super.key});
  @override
  State<SplashPages> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  @override
  void initState() {
    super.initState();
    // // _checkLoginStatus();
    // String? userJsonString = CacheHelper().getData('user');
    // if (userJsonString != null) {
    //   UserModel user = UserModel.fromJson(jsonDecode(userJsonString));
    //   print('User name is: ${user.name}');
    //   print('User email is: ${user.email}');
    // }
  }

  // Future<void> _checkLoginStatus() async {
  //   try {
  //     final token = await CacheHelper().getData('token');
  //     print('Token: $token');
  //     if (token != null) {
  //       GoRouter.of(context).pushReplacementNamed(Routes.layout[0]);
  //     } else {
  //       GoRouter.of(context).pushReplacementNamed(Routes.login);
  //     }
  //   } catch (e) {
  //     print('Error checking login status: $e');
  //     GoRouter.of(context).pushReplacementNamed(Routes.login);
  //   }
  // }

  _SplashPagesState();
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> splashPages = [
      {
        "img": ImagesAssets.splashImage1,
        "title": StringManager.splashP1Title.tr(context),
        "body": StringManager.splashP1Body.tr(context),
      },
      {
        "img": ImagesAssets.splashImage2,
        "title": StringManager.splashP2Title.tr(context),
        "body": StringManager.splashP2Body.tr(context),
      },
      {
        "img": ImagesAssets.splashImage3,
        "title": StringManager.splashP3Title.tr(context),
        "body": StringManager.splashP3Body.tr(context),
      },
      {
        "img": ImagesAssets.splashImage4,
        "title": StringManager.splashP4Title.tr(context),
        "body": StringManager.splashP4Body.tr(context),
      },
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String currentLang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 120,
        centerTitle: true,
        title: SizedBox(height: 120, child: Image.asset(ImagesAssets.appLogo)),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: splashPages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final page = splashPages[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        page["img"]!,
                        width: width * 0.9,
                        height: height * 0.4,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                      child: Text(
                        page["title"] ?? '',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                      child: Text(
                        page["body"] ?? '',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentIndex > 0)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        currentLang == "en"
                            ? ImagesAssets.arrowBack
                            : ImagesAssets.arrowNext,
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.fill,
                        color: ColorsManager.primary,
                      ),
                      onPressed: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                const Spacer(),
                Row(
                  children: List.generate(
                    splashPages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      width: _currentIndex == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == index
                                ? ColorsManager.primary
                                : Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      currentLang == "en"
                          ? ImagesAssets.arrowNext
                          : ImagesAssets.arrowBack,
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.fill,
                      color: ColorsManager.primary,
                    ),

                    onPressed: () => _goToNext(splashPages),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToNext(List<Map<String, String>> splashPages) async {
    if (splashPages.length - 1 > _currentIndex) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final token = prefs.getString('token'); // لاحظي هنا غيرناها
    } else {
      if (AppRoutes.token != null) {
        GoRouter.of(context).go(Routes.layout); // يروح للـ Layout مباشرة
      } else {
        GoRouter.of(context).go(Routes.login); // يروح للـ Login
      }
    }
  }
}
