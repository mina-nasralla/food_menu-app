import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/admin_dashboard/data/models/offer_model.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/menu_item_model.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../manager/menu_cubit.dart';

class OffersTab extends StatelessWidget {
  const OffersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Create Banner Button
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () => _showAddOfferDialog(context),
                    icon: const Icon(Icons.add),
                    label: Text(
                      AppLocalizations.of(context)!.createBanner,
                      style: const TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Offers Grid
            BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                if (state is MenuLoaded) {
                  if (state.offers.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(AppLocalizations.of(context)!.noOrders),
                    );
                  }

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 600,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.6,
                        ),
                        itemCount: state.offers.length,
                        itemBuilder: (context, index) {
                          return _buildOfferCard(context, state.offers[index]);
                        },
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context, OfferModel offer) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        children: [
          // Background Image Area
          Expanded(
            flex: 3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                offer.imageUrl != null && offer.imageUrl!.startsWith('http')
                    ? Image.network(
                  offer.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: Colors.grey[800]),
                )
                    : Container(color: Colors.grey[800]),

                // Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        offer.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Status Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: offer.isActive
                          ? Colors.green.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: offer.isActive ? Colors.green : Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      offer.isActive ? AppLocalizations.of(context)!.active : AppLocalizations.of(context)!.inactive,
                      style: TextStyle(
                        color: offer.isActive
                            ? Colors.green[400]
                            : Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Footer Area
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                        children: [
                          TextSpan(
                            text: '${AppLocalizations.of(context)!.itemsLabel} ',
                            style: TextStyle(color: Theme.of(context).hintColor),
                          ),
                          TextSpan(
                            text: context
                                .read<MenuCubit>()
                                .state is MenuLoaded
                                ? (context
                                .read<MenuCubit>()
                                .state as MenuLoaded)
                                .items
                                .where((item) =>
                                offer.linkedItemIds.contains(item.id))
                                .map((item) => item.name)
                                .join(', ')
                                : AppLocalizations.of(context)!.loading,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          offer.isActive
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                        iconSize: 20,
                        onPressed: () {
                          context.read<MenuCubit>().toggleOfferStatus(offer.id);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.grey),
                        iconSize: 20,
                        onPressed: () {
                          _showAddOfferDialog(context, offer: offer);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        iconSize: 20,
                        onPressed: () {
                          context.read<MenuCubit>().deleteOffer(offer.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddOfferDialog(BuildContext context, {OfferModel? offer}) {
    final isEditing = offer != null;
    final titleController = TextEditingController(text: offer?.title);
    final descController = TextEditingController(text: offer?.description);
    final priceController = TextEditingController(
      text: offer?.price.toString(),
    );
    final imageController = TextEditingController(
      text:
      offer?.imageUrl ??
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500&q=80',
    );

    // Capture cubit from parent context
    final menuCubit = context.read<MenuCubit>();

    // Initialize Selection State
    List<String> selectedAddons = List.from(offer?.selectedAddonIds ?? []);
    List<MenuItem> selectedItems = [];

    if (menuCubit.state is MenuLoaded) {
      final state = menuCubit.state as MenuLoaded;
      if (offer?.linkedItemIds.isNotEmpty ?? false) {
        selectedItems =
            state.items
                .where((i) => offer!.linkedItemIds.contains(i.id))
                .toList();
      }
    }

    showDialog(
      context: context,
      builder: (dialogContext) =>
          StatefulBuilder(
        builder: (context, setState) {
          final l10n = AppLocalizations.of(context)!;
          // Aggregate available addons from all selected items
                final Set<String> availableAddonIds = {};
                final List<dynamic> aggregatedAddons = [];

                for (var item in selectedItems) {
                  for (var addon in item.availableAddOns) {
                    if (availableAddonIds.add(addon.id)) {
                      aggregatedAddons.add(addon);
                    }
                  }
                }

                // Calculation Logic
                double itemsTotal = selectedItems.fold(
                    0, (sum, item) => sum + item.basePrice);
                double addonsTotal = 0;
                for (var addon in aggregatedAddons) {
                  if (selectedAddons.contains(addon.id)) {
                    addonsTotal += addon.price;
                  }
                }
                double totalValue = itemsTotal + addonsTotal;

                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  titlePadding: const EdgeInsets.all(24),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 8),
                  actionsPadding: const EdgeInsets.all(24),
                  title: Text(
            isEditing ? AppLocalizations.of(context)!.editOffer : AppLocalizations.of(context)!.createBanner,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
                  content: SizedBox(
                    width: 500, // Fixed width for better layout on desktop
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- Header Section ---
                   Text(AppLocalizations.of(context)!.header, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
                  const SizedBox(height: 8),
                  TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.headline,
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: descController,
                            maxLines: 2,
                            decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.subtitleDescription,
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // --- Visuals Section ---
                  Text(AppLocalizations.of(context)!.visuals, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
                          const SizedBox(height: 8),
                          TextField(
                            controller: imageController,
                            decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.imageUrl,
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.link),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // --- Content Section ---
                   Text(AppLocalizations.of(context)!.includedItems, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
                          const SizedBox(height: 8),
                          // Multi-Item Selection Dropdown
                          Builder(
                              builder: (context) {
                                final state = menuCubit.state;
                                final l10n = AppLocalizations.of(context)!;
                                if (state is! MenuLoaded) return Center(
                                    child: Text(l10n.loading));

                                return Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).dividerColor),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      tilePadding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      title: Text(
                                        '${l10n.selectedItems} (${selectedItems.length})',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle: Text(
                                        '${l10n.subtotal}: \$${itemsTotal.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            color: Theme.of(context).hintColor,
                                            fontSize: 12),
                                      ),
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          child: ListView.separated(
                                            separatorBuilder: (c,
                                                i) => const Divider(height: 1),
                                            itemCount: state.items.length,
                                            itemBuilder: (context, index) {
                                              final item = state.items[index];
                                              final isSelected = selectedItems
                                                  .any((i) => i.id == item.id);
                                              return CheckboxListTile(
                                                activeColor: Colors.blue,
                                                contentPadding: const EdgeInsets
                                                    .symmetric(horizontal: 16),
                                                title: Text(item.name),
                                                subtitle: Text(
                                                    '\$${item.basePrice
                                                        .toStringAsFixed(2)}'),
                                                value: isSelected,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    if (value == true) {
                                                      selectedItems.add(item);
                                                    } else {
                                                      selectedItems
                                                          .removeWhere((i) =>
                                                      i.id == item.id);
                                                    }
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),

                          // Addons Section (only if any item selected)
                          if (aggregatedAddons.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  tilePadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  title: Text(
                                    '${l10n.selectedAddons} (${selectedAddons.length})',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    '${l10n.subtotal}: \$${addonsTotal.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor, fontSize: 12),
                                  ),
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: ListView.separated(
                                          separatorBuilder: (c,
                                              i) => const Divider(height: 1),
                                          itemCount: aggregatedAddons.length,
                                          itemBuilder: (context, index) {
                                            final addon = aggregatedAddons[index];
                                            final isSelected = selectedAddons
                                                .contains(addon.id);
                                            return CheckboxListTile(
                                              activeColor: Colors.blue,
                                              contentPadding: const EdgeInsets
                                                  .symmetric(horizontal: 16),
                                              title: Text(addon.name),
                                              subtitle: Text('+\$${addon.price
                                                  .toStringAsFixed(2)}'),
                                              value: isSelected,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  if (value == true) {
                                                    selectedAddons.add(
                                                        addon.id);
                                                  } else {
                                                    selectedAddons.remove(
                                                        addon.id);
                                                  }
                                                });
                                              },
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],

                          const SizedBox(height: 24),
                          // --- Pricing Section ---
                          Text(AppLocalizations.of(context)!.pricing, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
                          const SizedBox(height: 8),
                          TextField(
                            controller: priceController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.finalPrice,
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              prefixIcon: const Icon(Icons.attach_money),
                              suffixIcon: totalValue > 0 ? Container(
                                margin: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange[100],
                                    foregroundColor: Colors.orange[900],
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                  ),
                                  onPressed: () {
                                    priceController.text =
                                        totalValue.toStringAsFixed(2);
                                  },
                                  child: Text(
                                      '${l10n.useEst}: \$${totalValue.toStringAsFixed(2)}'),
                                ),
                              ) : null,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    final newOffer = OfferModel(
                      id: isEditing ? offer.id : const Uuid().v4(),
                      title: titleController.text,
                      description: descController.text,
                      price: double.tryParse(priceController.text) ?? 0.0,
                      imageUrl: imageController.text,
                      isActive: isEditing ? offer.isActive : true,
                      linkedItemIds: selectedItems.map((e) => e.id).toList(),
                      selectedAddonIds: selectedAddons,
                    );

                    if (isEditing) {
                      menuCubit.deleteOffer(offer.id);
                      menuCubit.addOffer(newOffer);
                    } else {
                      menuCubit.addOffer(newOffer);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(isEditing ? AppLocalizations.of(context)!.save : AppLocalizations.of(context)!.create),
              ),
            ],
          );
        },
      ),
    );

  }
}
