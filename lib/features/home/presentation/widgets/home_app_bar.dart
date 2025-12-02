import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/core/config/locale/locale_state.dart';
import 'package:food_menu_app/core/utilities/app_images.dart';
import '../../../../core/config/locale/locale_cubit.dart';
import '../../../../core/config/theme/theme_cubit.dart';
import '../../../../core/utilities/app_colors.dart';
import '../../../../core/utilities/app_fonts.dart';

/// Custom AppBar widget for home page
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset(Assets.logo),
      actions: [
        // Language Toggle Button
        BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                context.read<LocaleCubit>().toggleLanguage();
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: const Size(48, 48),
              ),
              child: Text(
                state.languageCode == 'en' ? 'AR' : 'EN',
                style: AppFonts.styleBold16(context).copyWith(
                  color: AppColors.white,
                ),
              ),
            );
          },
        ),
        // Dark Mode Toggle Button
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              icon: Icon(
                state == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                color: AppColors.white,
              ),
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
