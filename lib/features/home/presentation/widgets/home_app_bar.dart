import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/locale/locale_cubit.dart';
import '../../../../core/config/locale/locale_state.dart';
import '../../../../core/config/theme/theme_cubit.dart';
import '../../../../core/utilities/app_fonts.dart';
import '../../../../core/utilities/app_images.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/routing/route_constants.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 16,
      title: Row(
        children: [
          Image.asset(Assets.logo, height: 40),
        ],
      ),
      actions: [
        // Language Toggle
        BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                context.read<LocaleCubit>().toggleLanguage();
              },
              child: Text(
                state.languageCode == 'en' ? 'AR' : 'EN',
                style: AppFonts.styleBold16(context).copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            );
          },
        ),
        
        // Theme Toggle
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              icon: Icon(
                themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                color: theme.colorScheme.onSurface,
              ),
            );
          },
        ),

        // I am Chief Button
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 8.0),
          child: ElevatedButton(
            onPressed: () {
              context.push(RouteConstants.loginPath);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text(
              'I\'am Chief',
              style: AppFonts.styleRegular14(context).copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

