import 'package:equatable/equatable.dart';

class RestaurantProfile extends Equatable {
  final String name;
  final String cuisine;
  final String location;
  final String phone;
  final String website;
  final String facebook;
  final String whatsapp;
  final List<WorkingHour> workingHours;
  final bool isOpen;
  final String logoUrl;
  final String coverUrl;

  const RestaurantProfile({
    required this.name,
    required this.cuisine,
    required this.location,
    required this.phone,
    required this.website,
    required this.facebook,
    required this.whatsapp,
    required this.workingHours,
    required this.isOpen,
    required this.logoUrl,
    required this.coverUrl,
  });

  @override
  List<Object?> get props => [
        name,
        cuisine,
        location,
        phone,
        website,
        facebook,
        whatsapp,
        workingHours,
        isOpen,
        logoUrl,
        coverUrl,
      ];

  RestaurantProfile copyWith({
    String? name,
    String? cuisine,
    String? location,
    String? phone,
    String? website,
    String? facebook,
    String? whatsapp,
    List<WorkingHour>? workingHours,
    bool? isOpen,
    String? logoUrl,
    String? coverUrl,
  }) {
    return RestaurantProfile(
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      facebook: facebook ?? this.facebook,
      whatsapp: whatsapp ?? this.whatsapp,
      workingHours: workingHours ?? this.workingHours,
      isOpen: isOpen ?? this.isOpen,
      logoUrl: logoUrl ?? this.logoUrl,
      coverUrl: coverUrl ?? this.coverUrl,
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
