import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/core/config/locale/locale_state.dart';
import 'package:food_menu_app/core/utilities/app_images.dart';
import '../../../../core/config/locale/locale_cubit.dart';
import '../../../../core/config/theme/theme_cubit.dart';
import '../../../../core/utilities/app_fonts.dart';

/// Custom AppBar widget for restaurant menu page
class RestaurantMenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RestaurantMenuAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Assets.logo, height: 32),
        ],
      ),
      centerTitle: false,
      actions: [
        // Language Toggle Button
        BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                context.read<LocaleCubit>().toggleLanguage();
              },
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: const Size(48, 48),
              ),
              child: Text(
                state.languageCode == 'en' ? 'AR' : 'EN',
                style: AppFonts.styleBold16(context).copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            );
          },
        ),
        // Dark Mode Toggle Button
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              icon: Icon(
                themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              ),
              color: theme.colorScheme.onSurface,
              tooltip: themeMode == ThemeMode.dark 
                  ? 'Switch to Light Mode' 
                  : 'Switch to Dark Mode',
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
