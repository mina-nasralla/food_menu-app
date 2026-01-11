import 'dart:convert';
import 'package:food_menu_app/features/restaurant_menu/data/models/addon_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/config/google_sheets_config.dart';
import '../models/category_model.dart';
import '../models/menu_item_model.dart';
import '../models/restaurant_model.dart';

class RestaurantRepository {
  final http.Client _client;

  RestaurantRepository({http.Client? client})
      : _client = client ?? http.Client();

  Future<RestaurantProfile> getRestaurantProfile() async {
    final url = Uri.parse(
        '${GoogleSheetsConfig.scriptUrl}?sheet=${GoogleSheetsConfig.restaurantProfileSheet}');

    final response = await _client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return RestaurantProfile.fromJson(data.first);
      } else {
        throw Exception('Restaurant profile not found');
      }
    } else {
      throw Exception(
          'Failed to load restaurant profile: ${response.statusCode}');
    }
  }

  Future<List<CategoryModel>> getMenuCategories() async {
    final url = Uri.parse(
        '${GoogleSheetsConfig.scriptUrl}?sheet=${GoogleSheetsConfig.categoriesSheet}');

    final response = await _client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  }

  Future<List<MenuItem>> getMenuItems({String? categoryId}) async {
    final url = Uri.parse(
        '${GoogleSheetsConfig.scriptUrl}?sheet=${GoogleSheetsConfig.menuItemsSheet}');

    final response = await _client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<MenuItem> items = data.map((e) => MenuItem.fromJson(e)).toList();
      
      if (categoryId != null) {
        items = items.where((item) => item.categoryId == categoryId).toList();
      }
      
      return items;
    } else {
      throw Exception('Failed to load menu items: ${response.statusCode}');
    }
  }

  Future<List<AddOn>> getAddons() async {
    final url = Uri.parse(
        '${GoogleSheetsConfig.scriptUrl}?sheet=${GoogleSheetsConfig.addonsSheet}');

    final response = await _client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => AddOn.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load addons: ${response.statusCode}');
    }
  }

  Future<void> submitOrder({
    required String customerName,
    required String customerPhone,
    required String address,
    required double? latitude,
    required double? longitude,
    required List<Map<String, dynamic>> items,
    required String? notes,
    required double totalPrice,
  }) async {
    final url = Uri.parse(GoogleSheetsConfig.scriptUrl);

    // Reverting to sending JSON string with text/plain header to bypass CORS but still send JSON body
    // The script expects a JSON string to parse
    final body = jsonEncode({
      'action': 'addOrder',
      'data': {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'customer_name': customerName,
        'customer_phone': customerPhone,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'items': jsonEncode(items),
        'notes': notes,
        'total_price': totalPrice,
        'status': 'pending',
        'created_at': DateTime.now().toIso8601String(),
      },
    });
    
    print('Submitting order with body: $body');

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'text/plain'},
      body: body,
    );
    
    print('Order submission response: ${response.statusCode}');
    print('Order submission body: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 302) {
      throw Exception('Failed to place order: ${response.body}');
    }
    
    // Check for logical errors from string (e.g. {"success":false, "error":...})
    if (response.body.contains('"error"') || response.body.contains('"success":false')) {
       throw Exception('Server reported error: ${response.body}');
    }
  }
}

