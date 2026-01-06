import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/restaurant_model.dart';
import '../../data/repositories/restaurant_repository.dart';

abstract class RestaurantProfileState extends Equatable {
  const RestaurantProfileState();

  @override
  List<Object?> get props => [];
}

class RestaurantProfileInitial extends RestaurantProfileState {}

class RestaurantProfileLoading extends RestaurantProfileState {}

class RestaurantProfileLoaded extends RestaurantProfileState {
  final RestaurantProfile profile;

  const RestaurantProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class RestaurantProfileError extends RestaurantProfileState {
  final String message;

  const RestaurantProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class RestaurantProfileCubit extends Cubit<RestaurantProfileState> {
  final RestaurantRepository _repository;

  RestaurantProfileCubit({RestaurantRepository? repository})
      : _repository = repository ?? RestaurantRepository(),
        super(RestaurantProfileInitial());

  Future<void> fetchProfile() async {
    try {
      emit(RestaurantProfileLoading());
      final profile = await _repository.getRestaurantProfile();
      emit(RestaurantProfileLoaded(profile));
    } catch (e) {
      emit(RestaurantProfileError(e.toString()));
    }
  }
}
