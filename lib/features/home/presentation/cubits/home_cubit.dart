import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/restaurant_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void initialize() async {
    emit(state.copyWith(status: HomeStatus.loading));
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    emit(state.copyWith(
      status: HomeStatus.success,
      recommended: Restaurant.recommended,
      nearest: Restaurant.nearest,
      recentlyViewed: [Restaurant.recommended.first], // Dummy recently viewed
    ));
  }
}
