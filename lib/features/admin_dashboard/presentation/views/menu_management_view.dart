import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            title: const Text('Menu Management'),
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Offers'),
                Tab(text: 'Items'),
                Tab(text: 'Addons'),
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
