import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/core/utilities/app_fonts.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../restaurant_menu/presentation/cubits/restaurant_menu_cubit.dart';
import '../../../restaurant_menu/presentation/cubits/restaurant_menu_state.dart';
import '../widgets/order_confirmation_dialog.dart';
import 'map_picker_screen.dart';

/// Checkout view for collecting delivery information
class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  String? _selectedAddress;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _openMapPicker() async {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Show choice dialog
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.address),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.map, color: theme.colorScheme.primary),
              title: Text(l10n.selectOnMap),
              subtitle: Text(l10n.chooseLocationVisually),
              onTap: () => Navigator.pop(context, 'map'),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.edit, color: theme.colorScheme.primary),
              title: Text(l10n.typeAddress),
              subtitle: Text(l10n.enterAddressManually),
              onTap: () => Navigator.pop(context, 'manual'),
            ),
          ],
        ),
      ),
    );

    if (choice == 'map') {
      // Open map picker
      final result = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => MapPickerScreen(
            initialAddress: _selectedAddress,
          ),
        ),
      );

      if (result != null) {
        setState(() {
          _selectedAddress = result;
        });
      }
    } else if (choice == 'manual') {
      // Show text input dialog
      // Use existing address only if it's not a coordinate string
      final initialText = _selectedAddress != null && !_selectedAddress!.startsWith('Lat:') 
          ? _selectedAddress 
          : '';
      final controller = TextEditingController(text: initialText);
      final result = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.address),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: l10n.addressHint,
              border: const OutlineInputBorder(),
            ),
            maxLines: 3,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: Text(l10n.confirm),
            ),
          ],
        ),
      );

      if (result != null && result.isNotEmpty) {
        setState(() {
          _selectedAddress = result;
        });
      }
      controller.dispose();
    }
  }

  void _showOrderConfirmation() {
    if (_formKey.currentState!.validate()) {
      if (_selectedAddress == null || _selectedAddress!.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.fieldRequired),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        return;
      }

      showDialog(
        context: context,
        builder: (context) => OrderConfirmationDialog(
          name: _nameController.text,
          phoneNumber: _phoneController.text,
          address: _selectedAddress!,
          deliveryNotes: _notesController.text.isEmpty ? null : _notesController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.checkoutTitle),
        centerTitle: false,
      ),
      body: BlocBuilder<RestaurantMenuCubit, RestaurantMenuState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Delivery Information Section
                  Text(
                    l10n.deliveryInfo,
                    style: AppFonts.styleBold20(context),
                  ),
                  const SizedBox(height: 24),

                  // Name Field
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: l10n.name,
                      hintText: l10n.nameHint,
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.fieldRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Phone Number Field
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: l10n.phoneNumber,
                      hintText: l10n.phoneNumberHint,
                      prefixIcon: const Icon(Icons.phone_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.fieldRequired;
                      }
                      // Basic phone validation (at least 10 digits)
                      final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
                      if (digitsOnly.length < 10) {
                        return l10n.invalidPhone;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Address Selection Button
                  InkWell(
                    onTap: _openMapPicker,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.dividerColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.address,
                                  style: AppFonts.styleRegular12(context).copyWith(
                                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _selectedAddress ?? l10n.addressHint,
                                  style: _selectedAddress != null
                                      ? AppFonts.styleRegular14(context)
                                      : AppFonts.styleRegular14(context).copyWith(
                                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                                        ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Delivery Notes Field (Optional)
                  TextFormField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: l10n.deliveryNotes,
                      hintText: l10n.deliveryNotesHint,
                      prefixIcon: const Icon(Icons.note_outlined),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 32),

                  // Order Summary Section
                  Text(
                    l10n.orderSummary,
                    style: AppFonts.styleBold20(context),
                  ),
                  const SizedBox(height: 16),

                  // Summary Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.dividerColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          context,
                          l10n.itemsCount(state.cartItems.length),
                          '',
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          context,
                          l10n.subtotal,
                          '\$${state.totalCartPrice.toStringAsFixed(2)}',
                        ),

                        const Divider(height: 24),
                        _buildSummaryRow(
                          context,
                          l10n.total,
                          '\$${state.totalCartPrice.toStringAsFixed(2)}',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Confirm Order Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _showOrderConfirmation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        l10n.confirmOrder,
                        style: AppFonts.styleBold18(context).copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
  }) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? AppFonts.styleBold16(context)
              : AppFonts.styleRegular14(context).copyWith(
                  color: theme.textTheme.bodyMedium?.color,
                ),
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style: isBold
                ? AppFonts.styleBold16(context).copyWith(
                    color: theme.colorScheme.primary,
                  )
                : AppFonts.styleRegular14(context),
          ),
      ],
    );
  }
}
