import 'package:equatable/equatable.dart';
import '../../data/models/restaurant_model.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Restaurant> recommended;
  final List<Restaurant> nearest;
  final List<Restaurant> recentlyViewed;

  const HomeState({
    this.status = HomeStatus.initial,
    this.recommended = const [],
    this.nearest = const [],
    this.recentlyViewed = const [],
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Restaurant>? recommended,
    List<Restaurant>? nearest,
    List<Restaurant>? recentlyViewed,
  }) {
    return HomeState(
      status: status ?? this.status,
      recommended: recommended ?? this.recommended,
      nearest: nearest ?? this.nearest,
      recentlyViewed: recentlyViewed ?? this.recentlyViewed,
    );
  }

  @override
  List<Object?> get props => [status, recommended, nearest, recentlyViewed];
}
