import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'core/config/routing/app_router.dart';
import 'core/config/theme/app_theme.dart';
import 'core/config/locale/locale_cubit.dart';
import 'core/config/locale/locale_state.dart';

import 'core/config/theme/theme_cubit.dart';
import 'features/home/presentation/cubits/home_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => HomeCubit()..initialize()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, localeState) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return Builder(
                builder: (context) {
                  return MaterialApp.router(
                    title: 'Food Menu App',
                    debugShowCheckedModeBanner: false,
                    
                    // Localization Configuration
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en'), // English
                      Locale('ar'), // Arabic
                    ],
                    locale: Locale(localeState.languageCode),
                    
                    // Theme Configuration with Responsive Fonts
                    theme: AppTheme.lightTheme(context),
                    darkTheme: AppTheme.darkTheme(context),
                    themeMode: themeMode,
                    
                    // Router Configuration for Deep Linking
                    routerConfig: AppRouter.router,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
