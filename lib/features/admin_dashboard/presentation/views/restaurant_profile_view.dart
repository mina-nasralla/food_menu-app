import 'package:flutter/material.dart';

class RestaurantProfileView extends StatelessWidget {
  const RestaurantProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Silver App Bar with Cover Image
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('My Restaurant'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://placeholder.com/wp-content/uploads/2018/10/placeholder.com-logo1.jpg', // Placeholder for Cover
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                         return Container(color: Colors.grey[300], child: const Icon(Icons.image, size: 50));
                    },
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black54,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                   // Logo and Basic Info
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.restaurant, size: 40, color: Colors.white),
                        // backgroundImage: NetworkImage('...'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The Tasty Spoon',
                              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Italian Cuisine',
                              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                       IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Detail Items
                  _buildProfileItem(context, Icons.location_on, 'Location', '123 Main St, Cairo, Egypt'),
                  _buildProfileItem(context, Icons.phone, 'Phone', '+20 123 456 7890'),
                  _buildProfileItem(context, Icons.link, 'Website', 'www.tastyspoon.com'),
                  _buildProfileItem(context, Icons.facebook, 'Facebook', 'fb.com/tastyspoon'),
                  _buildWhatsappItem(context, '+20 123 456 7899'),
                  
                  const SizedBox(height: 32),
                  
                  // Visitors Counter
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.visibility, size: 32, color: theme.colorScheme.onSecondaryContainer),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Visitors',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                            ),
                            Text(
                              '15,234',
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildWhatsappItem(BuildContext context, String number) {
     return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.chat_bubble, color: Colors.green, size: 24), // Using generic icon as font_awesome might need import
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('WhatsApp', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text(number, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
