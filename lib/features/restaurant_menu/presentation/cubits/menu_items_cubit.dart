import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/menu_item_model.dart';
import '../../data/repositories/restaurant_repository.dart';

abstract class MenuItemsState extends Equatable {
  const MenuItemsState();

  @override
  List<Object?> get props => [];
}

class MenuItemsInitial extends MenuItemsState {}

class MenuItemsLoading extends MenuItemsState {}

class MenuItemsLoaded extends MenuItemsState {
  final List<MenuItem> items;

  const MenuItemsLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class MenuItemsError extends MenuItemsState {
  final String message;

  const MenuItemsError(this.message);

  @override
  List<Object?> get props => [message];
}

class MenuItemsCubit extends Cubit<MenuItemsState> {
  final RestaurantRepository _repository;

  MenuItemsCubit({RestaurantRepository? repository})
      : _repository = repository ?? RestaurantRepository(),
        super(MenuItemsInitial());

  Future<void> fetchItems({String? categoryId}) async {
    try {
      emit(MenuItemsLoading());
      final items = await _repository.getMenuItems(categoryId: categoryId);
      emit(MenuItemsLoaded(items));
    } catch (e) {
      emit(MenuItemsError(e.toString()));
    }
  }
}
