import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/restaurant_repository.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoryCubit extends Cubit<CategoryState> {
  final RestaurantRepository _repository;

  CategoryCubit({RestaurantRepository? repository})
      : _repository = repository ?? RestaurantRepository(),
        super(CategoryInitial());

  Future<void> fetchCategories() async {
    try {
      emit(CategoryLoading());
      final categories = await _repository.getMenuCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
