import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../restaurant_menu/data/models/restaurant_model.dart';

abstract class RestaurantProfileState extends Equatable {
  const RestaurantProfileState();
  @override
  List<Object?> get props => [];
}

class RestaurantProfileInitial extends RestaurantProfileState {}

class RestaurantProfileLoaded extends RestaurantProfileState {
  final RestaurantProfile profile;

  const RestaurantProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class RestaurantProfileCubit extends Cubit<RestaurantProfileState> {
  RestaurantProfileCubit() : super(RestaurantProfileInitial());

  void loadProfile() {
    // Initial dummy data
    final initialProfile = RestaurantProfile(
      name: 'The Tasty Spoon',
      cuisine: 'Italian Cuisine',
      location: '123 Main St, Cairo, Egypt',
      phone: '+20 123 456 7890',
      website: 'www.tastyspoon.com',
      facebook: 'fb.com/tastyspoon',
      whatsapp: '+20 123 456 7899',
      isOpen: true,
      logoUrl: '',
      coverUrl: '',
      workingHours: const [
        WorkingHour(day: 'Monday', openingTime: '09:00 AM', closingTime: '10:00 PM'),
        WorkingHour(day: 'Tuesday', openingTime: '09:00 AM', closingTime: '10:00 PM'),
        WorkingHour(day: 'Wednesday', openingTime: '09:00 AM', closingTime: '10:00 PM'),
        WorkingHour(day: 'Thursday', openingTime: '09:00 AM', closingTime: '11:00 PM'),
        WorkingHour(day: 'Friday', openingTime: '01:00 PM', closingTime: '11:00 PM'),
        WorkingHour(day: 'Saturday', openingTime: '10:00 AM', closingTime: '11:00 PM'),
        WorkingHour(day: 'Sunday', openingTime: '10:00 AM', closingTime: '10:00 PM'),
      ],
    );
    emit(RestaurantProfileLoaded(initialProfile));
  }

  void updateProfile(RestaurantProfile updatedProfile) {
    emit(RestaurantProfileLoaded(updatedProfile));
  }

  void toggleStatus() {
    if (state is RestaurantProfileLoaded) {
      final current = (state as RestaurantProfileLoaded).profile;
      emit(RestaurantProfileLoaded(current.copyWith(isOpen: !current.isOpen)));
    }
  }
}
