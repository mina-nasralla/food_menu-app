import 'package:flutter/material.dart';
import '../../../../core/utilities/app_fonts.dart';
import '../../data/models/restaurant_model.dart';
import 'package:go_router/go_router.dart';

class NearestRestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const NearestRestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        context.push('/restaurant-menu');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image Section
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  restaurant.imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              
              const SizedBox(width: 16),

              // Info Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      restaurant.name,
                      style: AppFonts.styleBold16(context).copyWith(fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),

                    // Info Row: Distance | Rating
                    Row(
                      children: [
                        Text(
                          restaurant.distance,
                          style: TextStyle(
                            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '|', 
                            style: TextStyle(
                              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.3)
                            ),
                          ),
                        ),
                        const Icon(Icons.star, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating.toString(),
                          style: TextStyle(
                            fontSize: 14, 
                            fontWeight: FontWeight.w600,
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(1.9k)', // Static as per image for now
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Bottom Row: Delivery Fee & Favorite
                    Row(
                      children: [
                        // Delivery
                        const Icon(Icons.electric_moped, size: 18, color: Colors.green),
                        const SizedBox(width: 6),
                        Text(
                          '\$${restaurant.deliveryFee.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                          ),
                        ),
                        
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
