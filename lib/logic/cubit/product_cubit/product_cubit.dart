import 'package:e_com/core/api_services.dart';
import 'package:e_com/data/Model/category_model.dart';
import 'package:e_com/data/Model/product_model.dart';
import 'package:e_com/logic/cubit/category_cubit/category_state.dart';
import 'package:e_com/logic/cubit/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }

  void _initialize() async {
    emit(ProductLoadingState(state.products));
    try {
      List<ProductModel> products = await ApiService.fetchAllProduct();
      emit(ProductLoadedState(products));
    } catch (e) {
      emit(ProductErrorState(state.products, e.toString()));
    }
  }
}
