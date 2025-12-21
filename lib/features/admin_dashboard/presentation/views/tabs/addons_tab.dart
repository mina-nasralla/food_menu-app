import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/addon_model.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import '../../manager/menu_cubit.dart';
import 'package:uuid/uuid.dart';

class AddonsTab extends StatelessWidget {
  const AddonsTab({super.key});

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
                    maxCrossAxisExtent: 400,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 140, // Increased height for the action bar
                  ),
                  itemCount: state.addons.length,
                  itemBuilder: (context, index) {
                    final addon = state.addons[index];
                    return _buildAddonCard(context, addon);
                  },
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAddonDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAddonCard(BuildContext context, AddOn addon) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                   Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.add_box_outlined,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addon.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          addon.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${addon.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!addon.isAvailable)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        l10n.inactive.toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ),

                ],
              ),
            ),
          ),
          Divider(height: 1, color: theme.dividerColor.withOpacity(0.1)),
          // Actions Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  tooltip: addon.isAvailable ? l10n.active : l10n.inactive,
                  icon: Icon(
                    addon.isAvailable ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: addon.isAvailable ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => context.read<MenuCubit>().toggleAddonVisibility(addon.id),
                ),
                IconButton(
                  tooltip: l10n.edit,
                  icon: const Icon(Icons.edit_outlined, size: 20, color: Colors.orange),
                  onPressed: () => _showAddAddonDialog(context, addon: addon),
                ),
                IconButton(
                  tooltip: l10n.delete,
                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                  onPressed: () => context.read<MenuCubit>().deleteAddon(addon.id),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddAddonDialog(BuildContext context, {AddOn? addon}) {
    final isEditing = addon != null;
    final nameController = TextEditingController(text: addon?.name);
    final descController = TextEditingController(text: addon?.description);
    final priceController = TextEditingController(text: addon?.price.toString());

    // Capture cubit
    final menuCubit = context.read<MenuCubit>();

    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isEditing ? l10n.editAddon : l10n.addNewAddon),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: l10n.addonName),
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                final newAddon = AddOn(
                  id: isEditing ? addon.id : const Uuid().v4(),
                  name: nameController.text,
                  description: descController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                );

                if (isEditing) {
                    menuCubit.updateAddon(newAddon);
                } else {
                    menuCubit.addAddon(newAddon);
                }
                Navigator.pop(dialogContext);
              }
            },
            child: Text(isEditing ? l10n.save : l10n.create),
          ),
        ],
      ),
    );
  }
}
