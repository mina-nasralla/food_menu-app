import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/core/utilities/app_fonts.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routing/route_constants.dart';
import '../../../home/presentation/cubits/home_cubit.dart';
import '../../../home/presentation/cubits/home_state.dart';
import '../../data/models/order_model.dart';

/// Dialog for confirming order details before submission
class OrderConfirmationDialog extends StatelessWidget {
  final String phoneNumber;
  final String address;
  final String? deliveryNotes;

  const OrderConfirmationDialog({
    super.key,
    required this.phoneNumber,
    required this.address,
    this.deliveryNotes,
  });

  void _placeOrder(BuildContext context, HomeState state) {
    final cubit = context.read<HomeCubit>();
    
    // Create order
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: state.cartItems,
      phoneNumber: phoneNumber,
      address: address,
      deliveryNotes: deliveryNotes,
      subtotal: state.totalCartPrice,
      deliveryFee: 1.99,
      serviceFee: 0.30,
      total: state.totalCartPrice + 1.99 + 0.30,
      orderDate: DateTime.now(),
    );

    // Place order
    cubit.placeOrder(order);

    // Close dialog
    Navigator.of(context).pop();

    // Navigate to success screen
    context.go(RouteConstants.orderSuccessPath);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: theme.colorScheme.primary,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.orderConfirmation,
                          style: AppFonts.styleBold20(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Customer Information
                  Text(
                    l10n.customerInfo,
                    style: AppFonts.styleBold16(context),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(context, Icons.phone, l10n.phoneNumber, phoneNumber),
                  const SizedBox(height: 8),
                  _buildInfoRow(context, Icons.location_on, l10n.address, address),
                  if (deliveryNotes != null && deliveryNotes!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _buildInfoRow(context, Icons.note, l10n.deliveryNotes, deliveryNotes!),
                  ],
                  const SizedBox(height: 24),

                  // Order Summary
                  Text(
                    l10n.orderSummary,
                    style: AppFonts.styleBold16(context),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.dividerColor),
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
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          context,
                          l10n.deliveryFee,
                          '\$1.99',
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          context,
                          l10n.serviceFee,
                          '\$0.30',
                        ),
                        const Divider(height: 24),
                        _buildSummaryRow(
                          context,
                          l10n.total,
                          '\$${(state.totalCartPrice + 1.99 + 0.30).toStringAsFixed(2)}',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(l10n.cancel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () => _placeOrder(context, state),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            l10n.confirmAndPay,
                            style: AppFonts.styleBold16(context).copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppFonts.styleRegular12(context).copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
              Text(
                value,
                style: AppFonts.styleRegular14(context),
              ),
            ],
          ),
        ),
      ],
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
              ? AppFonts.styleRegular14(context)
              : AppFonts.styleRegular14(context).copyWith(
                  color: theme.textTheme.bodyMedium?.color,
                ),
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style: isBold
                ? AppFonts.styleRegular14(context).copyWith(
                    color: theme.colorScheme.primary,
                  )
                : AppFonts.styleRegular14(context),
          ),
      ],
    );
  }
}
