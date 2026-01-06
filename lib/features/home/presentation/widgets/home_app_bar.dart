import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/locale/locale_cubit.dart';
import '../../../../core/config/locale/locale_state.dart';
import '../../../../core/config/theme/theme_cubit.dart';
import '../../../../core/utilities/app_fonts.dart';
import '../../../../core/utilities/app_images.dart';


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


      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

