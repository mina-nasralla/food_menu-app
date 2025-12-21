import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/core/config/locale/locale_cubit.dart';
import 'package:food_menu_app/core/config/theme/theme_cubit.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/restaurant_model.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';



import '../../../../core/config/routing/route_constants.dart';
import '../manager/restaurant_profile_cubit.dart';

class RestaurantProfileView extends StatelessWidget {
  const RestaurantProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RestaurantProfileCubit()..loadProfile(),
      child: const _ProfileContent(),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocBuilder<RestaurantProfileCubit, RestaurantProfileState>(
        builder: (context, state) {
          if (state is RestaurantProfileLoaded) {
            final profile = state.profile;
            return LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 800;
                final horizontalPadding = isWide
                    ? (constraints.maxWidth - 800) / 2 + 24
                    : 20.0;

                return CustomScrollView(
                  slivers: [
                    _buildSliverAppBar(context, profile, l10n, isWide),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: 32,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMainInfo(context, theme, profile),
                            const SizedBox(height: 40),

                            _buildSectionHeader(
                              theme,
                              l10n.operationalStatus,
                              Icons.settings_remote,
                            ),
                            _buildOperationalStatusCard(
                              context,
                              theme,
                              profile,
                              l10n,
                            ),

                            const SizedBox(height: 40),
                            _buildWorkingHoursHeader(context, theme, l10n, profile),
                            _buildWorkingHoursList(theme, profile, l10n),

                            const SizedBox(height: 40),
                            _buildSectionHeader(
                              theme,
                              l10n.theme,
                              Icons.palette_outlined,
                            ),
                            _buildThemeLanguageSettings(
                              context,
                              theme,
                              isDark,
                              l10n,
                            ),

                            const SizedBox(height: 48),
                            _buildLogoutButton(context, l10n),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildSliverAppBar(
    BuildContext context,
    RestaurantProfile profile,
    AppLocalizations l10n,
    bool isWide,
  ) {
    return SliverAppBar(
      expandedHeight: isWide ? 300.0 : 220.0,
      pinned: true,
      stretch: true,
      centerTitle: true,
      title: Text(
        l10n.myRestaurant,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            profile.coverUrl.isNotEmpty
                ? Image.network(profile.coverUrl, fit: BoxFit.cover)
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0.6),
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.store,
                      size: 80,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: () => _showEditProfileDialog(context, profile),
          tooltip: l10n.updateProfile,
        ),
        IconButton(
          icon: const Icon(Icons.add_photo_alternate, color: Colors.white),
          onPressed: () => _showImageUrlDialog(context, profile, true),
          tooltip: l10n.updateBanner,
        ),
      ],
    );
  }

  Widget _buildMainInfo(
    BuildContext context,
    ThemeData theme,
    RestaurantProfile profile,
  ) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: theme.primaryColor.withOpacity(0.1),
              child: profile.logoUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 42,
                      backgroundImage: NetworkImage(profile.logoUrl),
                    )
                  : Icon(Icons.restaurant, size: 40, color: theme.primaryColor),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () => _showImageUrlDialog(context, profile, false),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                profile.cuisine,
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.primaryColor),
          const SizedBox(width: 10),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationalStatusCard(
    BuildContext context,
    ThemeData theme,
    RestaurantProfile profile,
    AppLocalizations l10n,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (profile.isOpen ? Colors.green : Colors.red).withOpacity(
                  0.1,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                profile.isOpen ? Icons.check_circle : Icons.do_not_disturb_on,
                color: profile.isOpen ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.isOpen ? l10n.open : l10n.closed,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: profile.isOpen ? Colors.green : Colors.red,
                    ),
                  ),
                  Text(
                    profile.isOpen
                        ? l10n.acceptingOrdersDesc
                        : l10n.notAcceptingOrdersDesc,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Switch(
              value: profile.isOpen,
              onChanged: (val) =>
                  context.read<RestaurantProfileCubit>().toggleStatus(),
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHoursList(
    ThemeData theme,
    RestaurantProfile profile,
    AppLocalizations l10n,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: profile.workingHours.length,
        separatorBuilder: (_, __) => Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: theme.dividerColor.withOpacity(0.05),
        ),
        itemBuilder: (context, index) {
          final hr = profile.workingHours[index];
          return ListTile(
            dense: true,
            title: Text(
              _localizeDay(l10n, hr.day),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              hr.isClosed
                  ? l10n.closed
                  : "${hr.openingTime} - ${hr.closingTime}",
              style: TextStyle(
                color: hr.isClosed ? Colors.red : theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildThemeLanguageSettings(
    BuildContext context,
    ThemeData theme,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        _buildSettingsTile(
          context,
          icon: isDark ? Icons.dark_mode : Icons.light_mode,
          title: l10n.theme,
          trailing: Switch(
            value: isDark,
            onChanged: (val) => context.read<ThemeCubit>().toggleTheme(),
          ),
        ),
        const SizedBox(height: 8),
        _buildSettingsTile(
          context,
          icon: Icons.language,
          title: l10n.language,
          trailing: TextButton(
            onPressed: () => context.read<LocaleCubit>().toggleLanguage(),
            child: Text(
              Localizations.localeOf(context).languageCode == 'en'
                  ? l10n.arabic
                  : l10n.english,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, AppLocalizations l10n) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: () => context.go(RouteConstants.homePath),
        icon: const Icon(Icons.logout, color: Colors.red),
        label: Text(
          l10n.logout,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: Colors.red.withOpacity(0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  String _localizeDay(AppLocalizations l10n, String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return l10n.monday;
      case 'tuesday':
        return l10n.tuesday;
      case 'wednesday':
        return l10n.wednesday;
      case 'thursday':
        return l10n.thursday;
      case 'friday':
        return l10n.friday;
      case 'saturday':
        return l10n.saturday;
      case 'sunday':
        return l10n.sunday;
      default:
        return day;
    }
  }

  void _showImageUrlDialog(BuildContext context, RestaurantProfile profile, bool isBanner) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: isBanner ? profile.coverUrl : profile.logoUrl);
    final cubit = context.read<RestaurantProfileCubit>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isBanner ? l10n.updateBanner : l10n.updateLogo),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: l10n.imageUrl,
            hintText: 'https://example.com/image.jpg',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          ElevatedButton(
            onPressed: () {
              final updated = isBanner 
                ? profile.copyWith(coverUrl: controller.text)
                : profile.copyWith(logoUrl: controller.text);
              cubit.updateProfile(updated);
              Navigator.pop(context);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingHoursHeader(BuildContext context, ThemeData theme, AppLocalizations l10n, RestaurantProfile profile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, size: 20, color: theme.primaryColor),
              const SizedBox(width: 10),
              Text(
                l10n.workingHours,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () => _showWorkingHoursDialog(context, profile),
            icon: const Icon(Icons.edit, size: 16),
            label: Text(l10n.edit),
          ),
        ],
      ),
    );
  }

  void _showWorkingHoursDialog(BuildContext context, RestaurantProfile profile) {
    final l10n = AppLocalizations.of(context)!;
    final cubit = context.read<RestaurantProfileCubit>();
    
    // Create copy for editing
    List<WorkingHour> editedHours = List.from(profile.workingHours);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.editWorkingHours),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: editedHours.length,
              itemBuilder: (context, index) {
                final hr = editedHours[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _localizeDay(l10n, hr.day),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Switch(
                            value: !hr.isClosed,
                            onChanged: (val) {
                              setDialogState(() {
                                editedHours[index] = hr.copyWith(isClosed: !val);
                              });
                            },
                          ),
                          Text(hr.isClosed ? l10n.isClosed : l10n.open),
                        ],
                      ),
                      if (!hr.isClosed) ...[
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: hr.openingTime,
                                decoration: InputDecoration(labelText: l10n.openingTime),
                                onChanged: (val) => editedHours[index] = hr.copyWith(openingTime: val),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                initialValue: hr.closingTime,
                                decoration: InputDecoration(labelText: l10n.closingTime),
                                onChanged: (val) => editedHours[index] = hr.copyWith(closingTime: val),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const Divider(),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
            ElevatedButton(
              onPressed: () {
                cubit.updateProfile(profile.copyWith(workingHours: editedHours));
                Navigator.pop(context);
              },
              child: Text(l10n.saveChanges),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, RestaurantProfile profile) {
    final nameCtrl = TextEditingController(text: profile.name);
    final cuisineCtrl = TextEditingController(text: profile.cuisine);
    final locationCtrl = TextEditingController(text: profile.location);
    final phoneCtrl = TextEditingController(text: profile.phone);
    final websiteCtrl = TextEditingController(text: profile.website);
    final facebookCtrl = TextEditingController(text: profile.facebook);
    final whatsappCtrl = TextEditingController(text: profile.whatsapp);

    final cubit = context.read<RestaurantProfileCubit>();

    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.updateProfile),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(labelText: l10n.itemName),
              ),
              TextField(
                controller: cuisineCtrl,
                decoration: InputDecoration(labelText: l10n.cuisineType),
              ),
              TextField(
                controller: locationCtrl,
                decoration: InputDecoration(labelText: l10n.location),
              ),
              TextField(
                controller: phoneCtrl,
                decoration: InputDecoration(labelText: l10n.phone),
              ),
              TextField(
                controller: websiteCtrl,
                decoration: InputDecoration(labelText: l10n.website),
              ),
              TextField(
                controller: facebookCtrl,
                decoration: InputDecoration(labelText: l10n.facebookUrl),
              ),
              TextField(
                controller: whatsappCtrl,
                decoration: InputDecoration(labelText: l10n.whatsappNumber),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final updated = profile.copyWith(
                name: nameCtrl.text,
                cuisine: cuisineCtrl.text,
                location: locationCtrl.text,
                phone: phoneCtrl.text,
                website: websiteCtrl.text,
                facebook: facebookCtrl.text,
                whatsapp: whatsappCtrl.text,
              );
              cubit.updateProfile(updated);
              Navigator.pop(context);
            },
            child: Text(l10n.update),
          ),
        ],
      ),
    );
  }
}
