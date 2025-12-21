import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import '../manager/menu_cubit.dart';
import 'tabs/offers_tab.dart';
import 'tabs/items_tab.dart';
import 'tabs/addons_tab.dart';

class MenuManagementView extends StatelessWidget {
  const MenuManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuCubit()..loadInitialData(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.menuManagement),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: [
                Tab(text: AppLocalizations.of(context)!.offersTab),
                Tab(text: AppLocalizations.of(context)!.itemsTab),
                Tab(text: AppLocalizations.of(context)!.addonsTab),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              OffersTab(),
              ItemsTab(),
              AddonsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
