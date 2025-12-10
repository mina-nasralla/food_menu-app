import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../data/models/menu_item_model.dart';

/// Spice level selector widget
class ItemSpiceLevelSelector extends StatelessWidget {
  final SpiceLevel selectedLevel;
  final ValueChanged<SpiceLevel> onLevelChanged;

  const ItemSpiceLevelSelector({
    super.key,
    required this.selectedLevel,
    required this.onLevelChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n!.spiceLevel,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: SpiceLevel.values.map((level) {
              final isSelected = selectedLevel == level;
              return ChoiceChip(
                label: Text(level.label),
                selected: isSelected,
                onSelected: (selected) => onLevelChanged(level),
                selectedColor: theme.colorScheme.primary,
                labelStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: isSelected 
                      ? theme.colorScheme.onPrimary 
                      : theme.colorScheme.onSurface,
                ),
                backgroundColor: theme.colorScheme.surface,
                side: BorderSide(
                  color: isSelected 
                      ? theme.colorScheme.primary 
                      : theme.dividerColor,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
