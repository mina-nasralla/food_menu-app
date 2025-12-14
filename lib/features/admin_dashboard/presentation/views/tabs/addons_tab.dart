import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/restaurant_menu/data/models/addon_model.dart';
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
            if (state.addons.isEmpty) {
              return const Center(child: Text('No addons available'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.addons.length,
              itemBuilder: (context, index) {
                final addon = state.addons[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Text(addon.name[0], style: TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                    title: Text(addon.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(addon.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('\$${addon.price.toStringAsFixed(2)}', 
                             style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showAddAddonDialog(context, addon: addon),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => context.read<MenuCubit>().deleteAddon(addon.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
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

  void _showAddAddonDialog(BuildContext context, {AddOn? addon}) {
    final isEditing = addon != null;
    final nameController = TextEditingController(text: addon?.name);
    final descController = TextEditingController(text: addon?.description);
    final priceController = TextEditingController(text: addon?.price.toString());
    
    // Capture cubit
    final menuCubit = context.read<MenuCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isEditing ? 'Edit Addon' : 'Add New Addon'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Addon Name'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                final newAddon = AddOn(
                  id: isEditing ? addon!.id : const Uuid().v4(),
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
            child: Text(isEditing ? 'Save' : 'Add'),
          ),
        ],
      ),
    );
  }
}
