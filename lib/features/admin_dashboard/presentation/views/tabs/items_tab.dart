import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/addon_model.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/menu_item_model.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import '../../manager/menu_cubit.dart';
import 'package:uuid/uuid.dart';

class ItemsTab extends StatelessWidget {
  const ItemsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          if (state is MenuLoaded) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 450,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    mainAxisExtent: 460, // Increased height for better spacing
                  ),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return _buildItemCard(context, item);
                  },
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, MenuItem item) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 6,
      shadowColor: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Image Section
          Stack(
            children: [
              Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? theme.cardColor : theme.canvasColor,
                ),
                child: item.imageUrl.startsWith('http')
                    ? Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.fastfood,
                          size: 60,
                          color: isDark ? Colors.grey[700] : Colors.grey[300],
                        ),
                      )
                    : Icon(Icons.fastfood, size: 60, color: Colors.grey[300]),
              ),
              if (!item.isAvailable)
                Positioned.fill(
                  child: Container(
                    color: Colors.black45,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                        ),
                        child: Text(
                          l10n.inactive.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // 2. Details Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '\$${item.basePrice.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  // Restore Addons Visibility
                  if (item.availableAddOns.isNotEmpty) ...[
                    Row(
                      children: [
                        Icon(Icons.add_circle_outline, 
                             size: 14, 
                             color: isDark ? Colors.grey[400] : Colors.grey[700]),
                        const SizedBox(width: 4),
                        Text(
                          l10n.addOns.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.grey[400] : Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: item.availableAddOns.take(4).map((addon) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: theme.primaryColor.withOpacity(0.2)),
                          ),
                          child: Text(
                            addon.name,
                            style: TextStyle(
                              fontSize: 10,
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),

          Divider(height: 1, color: theme.dividerColor.withOpacity(0.1)),

          // 3. Actions Section (Better Spacing)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? theme.cardColor.withOpacity(0.5) : theme.canvasColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionTile(
                    context,
                    icon: item.isAvailable ? Icons.visibility : Icons.visibility_off,
                    label: item.isAvailable ? l10n.active : l10n.inactive,
                    color: item.isAvailable ? Colors.blue : Colors.grey,
                    onTap: () => context.read<MenuCubit>().toggleItemVisibility(item.id),
                  ),
                ),
                _buildActionDivider(theme),
                Expanded(
                  child: _buildActionTile(
                    context,
                    icon: Icons.edit_note,
                    label: l10n.edit,
                    color: Colors.orange[800]!,
                    onTap: () => _showItemDialog(context, item: item),
                  ),
                ),
                _buildActionDivider(theme),
                Expanded(
                  child: _buildActionTile(
                    context,
                    icon: Icons.delete_sweep,
                    label: l10n.delete,
                    color: Colors.red[700]!,
                    onTap: () => context.read<MenuCubit>().deleteItem(item.id),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionDivider(ThemeData theme) {
    return Container(
      height: 24,
      width: 1,
      color: theme.dividerColor.withOpacity(0.1),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDialog(BuildContext context, {MenuItem? item}) {
    final isEditing = item != null;
    final nameController = TextEditingController(text: item?.name);
    final descController = TextEditingController(text: item?.description);
    final priceController = TextEditingController(text: item?.basePrice.toString());
    final imageController = TextEditingController(
      text: item?.imageUrl ?? 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500&q=80'
    );
    
    // Capture the cubit from the parent context
    final menuCubit = context.read<MenuCubit>();

    // Manage selected addons
    final List<AddOn> allAddons = menuCubit.state is MenuLoaded 
        ? (menuCubit.state as MenuLoaded).addons 
        : [];
    List<AddOn> selectedAddons = item?.availableAddOns ?? [];

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          final l10n = AppLocalizations.of(context)!;

          return AlertDialog(
            title: Text(isEditing ? l10n.editItem : l10n.addNewItem),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: l10n.itemName),
                  ),
                  TextField(
                    controller: descController,
                    decoration: InputDecoration(labelText: l10n.description),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: l10n.price),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: imageController,
                    decoration: InputDecoration(labelText: l10n.imageUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(l10n.selectAddons, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    height: 150,
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ListView.builder(
                      itemCount: allAddons.length,
                      itemBuilder: (context, index) {
                        final addon = allAddons[index];
                        final isSelected = selectedAddons.contains(addon);
                        return CheckboxListTile(
                          title: Text('${addon.name} (+\$${addon.price})'),
                          value: isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedAddons.add(addon);
                              } else {
                                selectedAddons.remove(addon);
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
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(l10n.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                    final newItem = MenuItem(
                      id: isEditing ? item.id : const Uuid().v4(),
                      name: nameController.text,
                      description: descController.text,
                      basePrice: double.tryParse(priceController.text) ?? 0.0,
                      imageUrl: imageController.text,
                      category: item?.category ?? 'custom',
                      availableAddOns: selectedAddons,
                    );
                    
                    if (isEditing) {
                        menuCubit.updateItem(newItem);
                    } else {
                        menuCubit.addItem(newItem);
                    }
                    Navigator.pop(dialogContext);
                  }
                },
                child: Text(isEditing ? l10n.save : l10n.create),
              ),
            ],
          );
        },
      ),
    );
  }
}
