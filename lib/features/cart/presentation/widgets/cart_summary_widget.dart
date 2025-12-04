import 'package:flutter/material.dart';
import 'package:food_menu_app/core/utilities/app_fonts.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';

/// Widget for displaying cart summary with pricing breakdown
class CartSummaryWidget extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final VoidCallback onCheckout;

  const CartSummaryWidget({
    super.key,
    required this.subtotal,
    this.deliveryFee = 1.99,
    this.serviceFee = 0.30,
    required this.onCheckout,
  });

  double get total => subtotal + deliveryFee + serviceFee;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Summary Header
            Text(
              l10n.summary,
              style: AppFonts.styleBold18(context),
            ),
            const SizedBox(height: 16),

            // Subtotal
            _buildSummaryRow(
              context,
              l10n.subtotal,
              '\$${subtotal.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 8),

            // Delivery Fee
            _buildSummaryRow(
              context,
              l10n.deliveryFee,
              '\$${deliveryFee.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 8),

            // Service Fee
            _buildSummaryRow(
              context,
              l10n.serviceFee,
              '\$${serviceFee.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 16),

            const Divider(),
            const SizedBox(height: 16),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.total,
                  style: AppFonts.styleBold20(context),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: AppFonts.styleBold20(context).copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Checkout Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.checkout,
                  style: AppFonts.styleBold18(context).copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFonts.styleRegular14(context).copyWith(
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        Text(
          value,
          style: AppFonts.styleRegular14(context),
        ),
      ],
    );
  }
}
