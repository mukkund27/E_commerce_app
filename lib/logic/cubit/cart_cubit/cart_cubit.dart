import 'dart:async';

import 'package:e_com/core/api_services.dart';
import 'package:e_com/data/Model/cart_item_model.dart';
import 'package:e_com/data/Model/product_model.dart';
import 'package:e_com/logic/cubit/cart_cubit/cart_state.dart';
import 'package:e_com/logic/cubit/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../user_cubit/user_cubit.dart';

class CartCubit extends Cubit<CartState> {
  final UserCubit _userCubit;
  StreamSubscription? streamSubscription;
  CartCubit(this._userCubit) : super(CartInitialState()) {

_handleUserState(_userCubit.state);
    //Listening to user cubit (for future updates)
   streamSubscription = _userCubit.stream.listen(_handleUserState);
  }


  void _handleUserState(UserState userState){
    if(userState is UserLoggedInState){
      _initialize(userState.userModel.sId!);
    }else if(state is UserLoggedOutState){
      emit(CartInitialState());
    }
  }

  void _initialize(String userId)async {
    emit(CartLoadingState(state.items));
    try {
      final items =await ApiService.fetchCartForUSer(userId);
      emit(CartLoadedState(items));
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  void addToCart(ProductModel product,int quantity)async{
    emit(CartLoadingState(state.items));

    try{
     if(_userCubit.state is UserLoggedInState){
       UserLoggedInState userLoggedInState=_userCubit.state as UserLoggedInState;
       
       CartModel cartModel=CartModel(product: product,quantity: quantity);
     final item=  await ApiService.addToCart(cartModel, userLoggedInState.userModel.sId!);
     emit(CartLoadedState(item));

     }else{
       throw "An error occurred while adding the item!";
     }
    }catch(e){
      emit(CartErrorState(e.toString(), state.items));
    }
  }
  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
