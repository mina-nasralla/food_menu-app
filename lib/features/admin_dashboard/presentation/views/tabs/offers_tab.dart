import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/features/admin_dashboard/data/models/offer_model.dart';
import '../../manager/menu_cubit.dart';
import 'package:uuid/uuid.dart';

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
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => _showAddOfferDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Create Banner', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
                    return const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text('No offers available'),
                    );
                  }
                  
                  // Use LayoutBuilder to determine columns based on width
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 1.6, 
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: state.offers.length,
                        itemBuilder: (context, index) {
                          return _buildOfferCard(context, state.offers[index]);
                        },
                      );
                    },
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
                      errorBuilder: (_,__,___) => Container(color: Colors.grey[800]),
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
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer.description,
                        style: const TextStyle(color: Colors.white70),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: offer.isActive ? Colors.green[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      offer.isActive ? 'Active' : 'Inactive',
                      style: TextStyle(
                        color: offer.isActive ? Colors.green[800] : Colors.grey[800],
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
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black87),
                      children: [
                        const TextSpan(text: 'Links to: ', style: TextStyle(color: Colors.grey)),
                        TextSpan(text: offer.linkTo, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(offer.isActive ? Icons.visibility : Icons.visibility_off, color: Colors.blue),
                        iconSize: 20,
                        onPressed: () {
                          context.read<MenuCubit>().toggleOfferStatus(offer.id);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.grey),
                        iconSize: 20,
                        onPressed: () {
                          // TODO: Implement Edit
                          _showAddOfferDialog(context, offer: offer); // Reuse add dialog for now
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
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
    final priceController = TextEditingController(text: offer?.price.toString());
    final imageController = TextEditingController(
      text: offer?.imageUrl ?? 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500&q=80'
    );
    
    // Capture cubit from parent context
    final menuCubit = context.read<MenuCubit>();

    // Simple state for LinkTo for this dialog
    String linkTo = offer?.linkTo ?? 'Category'; 

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(isEditing ? 'Edit Offer' : 'Create Banner'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Headline'),
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Subtitle/Description'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'Price (if applicable)'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: imageController,
                    decoration: const InputDecoration(labelText: 'Image URL'),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: linkTo,
                    decoration: const InputDecoration(labelText: 'Links to'),
                    items: ['Category', 'Item', 'External Link'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                         linkTo = newValue!;
                      });
                    },
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
                  if (titleController.text.isNotEmpty) {
                    final newOffer = OfferModel(
                      id: isEditing ? offer!.id : const Uuid().v4(),
                      title: titleController.text,
                      description: descController.text,
                      price: double.tryParse(priceController.text) ?? 0.0,
                      imageUrl: imageController.text,
                      linkTo: linkTo,
                      isActive: isEditing ? offer!.isActive : true,
                    );
                    
                    if (isEditing) {
                         menuCubit.deleteOffer(offer!.id);
                         menuCubit.addOffer(newOffer);
                    } else {
                        menuCubit.addOffer(newOffer);
                    }
                    Navigator.pop(dialogContext);
                  }
                },
                child: Text(isEditing ? 'Save' : 'Create'),
              ),
            ],
          );
        }
      ),
    );
  }
}
