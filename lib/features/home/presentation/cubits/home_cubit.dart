import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

/// Cubit for managing home page logic
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  /// Initialize home page
  void initialize() {
    // Add initialization logic here when needed
  }

  /// Toggle between grid and list view
  void toggleViewMode() {
    emit(state.copyWith(isGridView: !state.isGridView));
  }

  /// Get quantity for a specific item
  int getItemQuantity(String itemId) {
    return state.itemQuantities[itemId] ?? 1;
  }

  /// Increment item quantity
  void incrementItemQuantity(String itemId) {
    final currentQuantity = getItemQuantity(itemId);
    final updatedQuantities = Map<String, int>.from(state.itemQuantities);
    updatedQuantities[itemId] = currentQuantity + 1;
    emit(state.copyWith(itemQuantities: updatedQuantities));
  }

  /// Decrement item quantity
  void decrementItemQuantity(String itemId) {
    final currentQuantity = getItemQuantity(itemId);
    if (currentQuantity > 1) {
      final updatedQuantities = Map<String, int>.from(state.itemQuantities);
      updatedQuantities[itemId] = currentQuantity - 1;
      emit(state.copyWith(itemQuantities: updatedQuantities));
    }
  }
}
