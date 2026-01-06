import 'dart:convert';
import 'package:food_menu_app/features/restaurant_menu/data/models/addon_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/config/supabase_config.dart';
import '../models/category_model.dart';
import '../models/menu_item_model.dart';
import '../models/restaurant_model.dart';

class RestaurantRepository {
  final http.Client _client;

  RestaurantRepository({http.Client? client})
      : _client = client ?? http.Client();

  Future<RestaurantProfile> getRestaurantProfile() async {
    final url = Uri.parse(
        '${SupabaseConstants.url}/rest/v1/restaurant_profile?select=*');

    final response = await _client.get(
      url,
      headers: {
        'apikey': SupabaseConstants.anonKey,
        'Authorization': 'Bearer ${SupabaseConstants.anonKey}',
      },
    );

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
    final url =
        Uri.parse('${SupabaseConstants.url}/rest/v1/menu_categories?select=*');

    final response = await _client.get(
      url,
      headers: {
        'apikey': SupabaseConstants.anonKey,
        'Authorization': 'Bearer ${SupabaseConstants.anonKey}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  }

  Future<List<MenuItem>> getMenuItems({String? categoryId}) async {
    String urlString = '${SupabaseConstants.url}/rest/v1/menu_items?select=*';
    if (categoryId != null) {
      urlString += '&category_id=eq.$categoryId';
    }

    final url = Uri.parse(urlString);

    final response = await _client.get(
      url,
      headers: {
        'apikey': SupabaseConstants.anonKey,
        'Authorization': 'Bearer ${SupabaseConstants.anonKey}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => MenuItem.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load menu items: ${response.statusCode}');
    }
  }

  Future<List<AddOn>> getAddons() async {
    final url = Uri.parse('${SupabaseConstants.url}/rest/v1/menu_addons?select=*');

    final response = await _client.get(
      url,
      headers: {
        'apikey': SupabaseConstants.anonKey,
        'Authorization': 'Bearer ${SupabaseConstants.anonKey}',
      },
    );

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
    final url = Uri.parse('${SupabaseConstants.url}/rest/v1/orders');

    final body = jsonEncode({
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'items': jsonEncode(items), // Storing as stringified JSON based on user example
      'notes': notes,
      'total_price': totalPrice,
      'status': 'pending',
    });

    final response = await _client.post(
      url,
      headers: {
        'apikey': SupabaseConstants.anonKey,
        'Authorization': 'Bearer ${SupabaseConstants.anonKey}',
        'Content-Type': 'application/json',
        'Prefer': 'return=minimal',
      },
      body: body,
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to place order: ${response.body}');
    }
  }
}

