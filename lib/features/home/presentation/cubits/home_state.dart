import 'package:equatable/equatable.dart';

/// Home state
class HomeState extends Equatable {
  final bool isLoading;
  final bool isGridView;
  final Map<String, int> itemQuantities;

  const HomeState({
    this.isLoading = false,
    this.isGridView = true, // Default to grid view
    this.itemQuantities = const {},
  });

  @override
  List<Object?> get props => [isLoading, isGridView, itemQuantities];

  HomeState copyWith({
    bool? isLoading,
    bool? isGridView,
    Map<String, int>? itemQuantities,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isGridView: isGridView ?? this.isGridView,
      itemQuantities: itemQuantities ?? this.itemQuantities,
    );
  }
}
