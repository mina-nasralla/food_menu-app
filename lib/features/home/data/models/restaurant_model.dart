class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final List<String> tags;
  final String distance;
  final String time;
  final double deliveryFee;
  final double minOrder;
  final bool isFavorite;
  final bool isPromo;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.tags,
    required this.distance,
    required this.time,
    this.deliveryFee = 2.00,
    this.minOrder = 0.0,
    this.isFavorite = false,
    this.isPromo = false,
  });

  // Dummy data
  static List<Restaurant> get recommended => [
    const Restaurant(
      id: '1',
      name: 'Burger King',
      imageUrl: 'assets/img.jpg',
      rating: 4.5,
      tags: ['Burger', 'Fast Food'],
      distance: '1.2 km',
      time: '15-20 min',
      isPromo: true,
      minOrder: 10.0,
    ),
    const Restaurant(
      id: '2',
      name: 'Pizza Hut',
      imageUrl: 'assets/img.jpg',
      rating: 4.2,
      tags: ['Pizza', 'Italian'],
      distance: '2.5 km',
      time: '30-40 min',
    ),
    const Restaurant(
      id: '3',
      name: 'KFC',
      imageUrl: 'assets/img.jpg',
      rating: 4.0,
      tags: ['Chicken', 'Fast Food'],
      distance: '1.8 km',
      time: '20-30 min',
      deliveryFee: 1.50,
      isFavorite: true,
    ),
  ];

  static List<Restaurant> get nearest => [
    const Restaurant(
      id: '4',
      name: 'McDonalds',
      imageUrl: 'assets/img.jpg',
      rating: 4.8,
      tags: ['Burger', 'Fast Food'],
      distance: '0.5 km',
      time: '10-15 min',
      isPromo: true,
      minOrder: 5.0,
    ),
    const Restaurant(
      id: '5',
      name: 'Starbucks',
      imageUrl: 'assets/img.jpg',
      rating: 4.6,
      tags: ['Coffee', 'Drinks'],
      distance: '0.8 km',
      time: '10-15 min',
    ),
     const Restaurant(
      id: '6',
      name: 'Subway',
      imageUrl: 'assets/img.jpg',
      rating: 4.3,
      tags: ['Sandwich', 'Healthy'],
      distance: '1.0 km',
      time: '15-25 min',
    ),
  ];
}
