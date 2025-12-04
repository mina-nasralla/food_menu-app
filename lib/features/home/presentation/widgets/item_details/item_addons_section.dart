import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../data/models/addon_model.dart';

/// Add-ons section widget with quantity selectors
class ItemAddonsSection extends StatelessWidget {
  final List<AddOn> availableAddOns;
  final Set<String> selectedAddOnIds;
  final int mainQuantity;
  final int Function(String) getAddOnQuantity;
  final Function(String, bool) onAddOnToggle;
  final Function(String, int) onAddOnQuantityChange;

  const ItemAddonsSection({
    super.key,
    required this.availableAddOns,
    required this.selectedAddOnIds,
    required this.mainQuantity,
    required this.getAddOnQuantity,
    required this.onAddOnToggle,
    required this.onAddOnQuantityChange,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.addOns,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...availableAddOns.map((addon) {
            final isSelected = selectedAddOnIds.contains(addon.id);
            final addonQty = getAddOnQuantity(addon.id);
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => onAddOnToggle(addon.id, !isSelected),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                addon.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                addon.description,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            Text(
                              '+\$${addon.price.toStringAsFixed(2)}',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.dividerColor,
                                  width: 2,
                                ),
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : Colors.transparent,
                              ),
                              child: isSelected
                                  ? Icon(
                                      Icons.check,
                                      size: 16,
                                      color: theme.colorScheme.onPrimary,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Show quantity selector if selected and main quantity > 1
                  if (isSelected && mainQuantity > 1) ...[
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Row(
                        children: [
                          Text(
                            l10n.applyTo,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: theme.dividerColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (addonQty > 1) {
                                      onAddOnQuantityChange(addon.id, addonQty - 1);
                                    }
                                  },
                                  icon: const Icon(Icons.remove, size: 20),
                                  color: theme.colorScheme.primary,
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(),
                                ),
                                Container(
                                  constraints: const BoxConstraints(minWidth: 40),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$addonQty',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (addonQty < mainQuantity) {
                                      onAddOnQuantityChange(addon.id, addonQty + 1);
                                    }
                                  },
                                  icon: const Icon(Icons.add, size: 20),
                                  color: theme.colorScheme.primary,
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${l10n.ofPreposition} $mainQuantity',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
