import 'package:device_preview/device_preview.dart';
import 'package:electro/core/state_management/app_bloc_providers.dart';
import 'package:electro/core/theming/app_theme.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/theming/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../localization/app_localization.dart';
import '../localization/locale_cubit/locale_cubit.dart';
import '../routes/routes.dart';

Widget buildAppRoot(BuildContext context) {
  return MultiBlocProvider(
    providers: appBlocProviders(),
    child: Builder(
      builder: (context) {
        final localeState = context.watch<LocaleCubit>().state;
        final themeState = context.watch<ThemeCubit>().state;

        return MaterialApp.router(
          locale:
              localeState is ChangeLocaleState
                  ? localeState.locale
                  : const Locale("en"),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale("ar"), Locale("en")],
          debugShowCheckedModeBanner: false,
          title: 'Electro',
          routerConfig: AppRoutes.routes,
          builder: DevicePreview.appBuilder,
          theme: appTheme(),
          darkTheme: darkTheme(),
          themeMode: themeState.themeMode,
        );
      },
    ),
  );
}
