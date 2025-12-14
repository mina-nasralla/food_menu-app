import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/addon_model.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/menu_item_model.dart';
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
            if (state.items.isEmpty) {
              return const Center(child: Text('No items available'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = state.items[index];
                return _buildItemCard(context, item);
              },
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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Header with Image and Edit Button
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: item.imageUrl.startsWith('http') 
                      ? Image.network(item.imageUrl, fit: BoxFit.cover, errorBuilder: (_,__,___) => const Icon(Icons.fastfood, size: 50, color: Colors.grey))
                      : const Icon(Icons.fastfood, size: 50, color: Colors.grey)
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showItemDialog(context, item: item),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${item.basePrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
                if (item.availableAddOns.isNotEmpty) ...[
                  const Divider(height: 24),
                  Text(
                    'Addons (${item.availableAddOns.length})',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    children: item.availableAddOns.map((addon) => Chip(
                      label: Text('${addon.name} +\$${addon.price}'),
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      labelStyle: TextStyle(fontSize: 10, color: Theme.of(context).primaryColor),
                    )).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
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
    List<AddOn> selectedAddons = item?.availableAddOns ?? [];

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          final allAddons = (menuCubit.state is MenuLoaded) 
              ? (menuCubit.state as MenuLoaded).addons 
              : <AddOn>[];

          return AlertDialog(
            title: Text(isEditing ? 'Edit Item' : 'Add New Item'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Item Name'),
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'Base Price'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: imageController,
                    decoration: const InputDecoration(labelText: 'Image URL'),
                  ),
                  const SizedBox(height: 16),
                  const Text('Select Addons:', style: TextStyle(fontWeight: FontWeight.bold)),
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
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                    final newItem = MenuItem(
                      id: isEditing ? item!.id : const Uuid().v4(),
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
                child: Text(isEditing ? 'Save' : 'Add'),
              ),
            ],
          );
        },
      ),
    );
  }
}
