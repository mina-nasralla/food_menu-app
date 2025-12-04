import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_menu_app/core/utilities/app_fonts.dart';
import 'package:food_menu_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routing/route_constants.dart';
import '../../../home/presentation/cubits/home_cubit.dart';
import '../../../home/presentation/cubits/home_state.dart';

/// Success screen shown after order is placed
class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final order = state.lastOrder;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: 80,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Success Title
                  Text(
                    l10n.orderSuccess,
                    style: AppFonts.styleSemibold24(context),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Success Message
                  Text(
                    l10n.orderSuccessMessage,
                    style: AppFonts.styleRegular16(context).copyWith(
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Order Number Card
                  if (order != null)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Column(
                        children: [
                          Text(
                            l10n.orderNumber,
                            style: AppFonts.styleRegular14(context).copyWith(
                              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '#${order.id}',
                            style: AppFonts.styleBold20(context).copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          _buildOrderDetail(
                            context,
                            l10n.phoneNumber,
                            order.phoneNumber,
                          ),
                          const SizedBox(height: 12),
                          _buildOrderDetail(
                            context,
                            l10n.total,
                            '\$${order.total.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 48),

                  // Back to Home Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go(RouteConstants.homePath);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        l10n.backToHome,
                        style: AppFonts.styleBold18(context).copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderDetail(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFonts.styleRegular14(context).copyWith(
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
        Text(
          value,
          style: AppFonts.styleSemibold16(context),
        ),
      ],
    );
  }
}
