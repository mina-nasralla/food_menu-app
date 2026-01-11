import 'dart:convert';
import 'package:equatable/equatable.dart';

class RestaurantProfile extends Equatable {
  final String id;
  final String name;
  final String description;
  final String location;
  final String phone;
  final String? website;
  final String? facebook;
  final String? whatsapp;
  final List<WorkingHour> workingHours;
  final bool isOpen;
  final bool acceptsOrders;
  final String logoUrl;
  final String coverUrl;
  final double? latitude;
  final double? longitude;

  const RestaurantProfile({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.phone,
    this.website,
    this.facebook,
    this.whatsapp,
    required this.workingHours,
    required this.isOpen,
    required this.acceptsOrders,
    required this.logoUrl,
    required this.coverUrl,
    this.latitude,
    this.longitude,
  });

  factory RestaurantProfile.fromJson(Map<String, dynamic> json) {
    List<WorkingHour> parsedWorkingHours = [];
    final workingHoursRaw = json['working_hours'];

    if (workingHoursRaw != null &&
        workingHoursRaw is String &&
        workingHoursRaw.isNotEmpty) {
      try {
        final Map<String, dynamic> decoded = jsonDecode(workingHoursRaw);
        decoded.forEach((day, times) {
          if (times is Map<String, dynamic>) {
            parsedWorkingHours.add(WorkingHour(
              day: day,
              openingTime: times['open'] ?? '',
              closingTime: times['close'] ?? '',
            ));
          }
        });
      } catch (e) {
        // Fail silently or log error
      }
    }

    return RestaurantProfile(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      location: (json['address'] ?? json['location'])?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      website: json['website']?.toString(),
      facebook: json['facebook']?.toString(),
      whatsapp: json['whatsapp']?.toString(),
      isOpen: json['is_open'] == true || json['is_open'] == 'TRUE' || json['is_open'] == 1,
      acceptsOrders: json['accepts_orders'] == true || json['accepts_orders'] == 'TRUE' || json['accepts_orders'] == 1,
      logoUrl: (json['logo_url'] ?? json['logo'])?.toString() ?? '',
      coverUrl: (json['background_url'] ?? json['cover_url'] ?? json['cover_image'])?.toString() ?? '',
      latitude: double.tryParse(json['latitude']?.toString() ?? ''),
      longitude: double.tryParse(json['longitude']?.toString() ?? ''),
      workingHours: parsedWorkingHours,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        location,
        phone,
        website,
        facebook,
        whatsapp,
        workingHours,
        isOpen,
        acceptsOrders,
        logoUrl,
        coverUrl,
        latitude,
        longitude,
      ];

  RestaurantProfile copyWith({
    String? id,
    String? name,
    String? description,
    String? location,
    String? phone,
    String? website,
    String? facebook,
    String? whatsapp,
    List<WorkingHour>? workingHours,
    bool? isOpen,
    bool? acceptsOrders,
    String? logoUrl,
    String? coverUrl,
    double? latitude,
    double? longitude,
  }) {
    return RestaurantProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      facebook: facebook ?? this.facebook,
      whatsapp: whatsapp ?? this.whatsapp,
      workingHours: workingHours ?? this.workingHours,
      isOpen: isOpen ?? this.isOpen,
      acceptsOrders: acceptsOrders ?? this.acceptsOrders,
      logoUrl: logoUrl ?? this.logoUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

class WorkingHour extends Equatable {
  final String day;
  final String openingTime;
  final String closingTime;
  final bool isClosed;

  const WorkingHour({
    required this.day,
    required this.openingTime,
    required this.closingTime,
    this.isClosed = false,
  });

  factory WorkingHour.fromJson(Map<String, dynamic> json) {
    return WorkingHour(
      day: json['day'] ?? '',
      openingTime: json['opening_time'] ?? '',
      closingTime: json['closing_time'] ?? '',
      isClosed: json['is_closed'] ?? false,
    );
  }

  @override
  List<Object?> get props => [day, openingTime, closingTime, isClosed];

  WorkingHour copyWith({
    String? day,
    String? openingTime,
    String? closingTime,
    bool? isClosed,
  }) {
    return WorkingHour(
      day: day ?? this.day,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      isClosed: isClosed ?? this.isClosed,
    );
  }
}
