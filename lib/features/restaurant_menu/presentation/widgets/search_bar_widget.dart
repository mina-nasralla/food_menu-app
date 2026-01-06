import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/restaurant_menu/presentation/cubits/restaurant_menu_cubit.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: TextField(
                onChanged: (value) {
                  context.read<RestaurantMenuCubit>().setMenuSearchTerm(value);
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchHint,
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
