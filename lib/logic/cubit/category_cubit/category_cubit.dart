import 'package:e_com/core/api_services.dart';
import 'package:e_com/data/Model/category_model.dart';
import 'package:e_com/logic/cubit/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState()) {
    _initialize();
  }

  void _initialize() async {
    emit(CategoryLoadingState(state.categories));
    try {
      List<CategoryModel> categories=await ApiService.fetchAllCategory();
      emit(CategoryLoadedState(categories));

    } catch (e) {
      emit(CategoryErrorState(state.categories, e.toString()));
    }
  }
}
