import 'dart:developer';

import 'package:e_com/core/api_services.dart';
import 'package:e_com/data/Model/user_model.dart';
import 'package:e_com/logic/cubit/user_cubit/user_state.dart';
import 'package:e_com/logic/services/preferences.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()){
    _initialize();
  }

  void _initialize()async{
    final  userDetails=await Preferences.fetchUSerDetails();
    String? email=userDetails["email"];
    String? password=userDetails["password"];

    if(email == null || password == null){
      emit(UserLoggedOutState());
    }else {
      signIn(email: email, password: password);
    }
  }

  void _emitUserLoggedState({required UserModel userModel, required String email, required String password}) async {

    await Preferences.saveUserDetails(email, password);
    emit(UserLoggedInState(userModel));
  }

  void signIn({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      UserModel userModel = await ApiService.signIn(email: email, password: password);
      _emitUserLoggedState(userModel: userModel, email: email, password: password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void createAccount({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      UserModel userModel = await ApiService.createAccount(email: email, password: password);
      _emitUserLoggedState(userModel: userModel, email: email, password: password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void signOut()async{
    await Preferences.clear();
    emit(UserLoggedOutState());
  }
}
