import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';


 class SocialRegisterCubit extends Cubit<SocialRegisterStates>{

  SocialRegisterCubit() : super(SocialRegisterInitialState());

 static SocialRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String name ,
   required String email ,
   required String password ,
    required String phone ,
 }){
   emit(SocialRegisterLoadingState());
   FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password,
   ).then((value){
          userCreate(
           uId: value.user!.uid,
           phone: phone,
           email: email,
           name: name,
         );
      emit(SocialRegisterSuccessState(value.user!.uid));
   }).catchError((error){
     emit(SocialRegisterErrorState(error.toString()));
   });
  }

  void userCreate({
    required String name ,
    required String email ,
    required String uId ,
    required String phone ,
 }){
    SocialUserModel model= SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write you bio...',
      cover: 'https://as2.ftcdn.net/v2/jpg/02/97/24/51/1000_F_297245133_gBPfK0h10UM3y7vfoEiBC3ZXt559KZar.jpg',
      image: 'https://as2.ftcdn.net/v2/jpg/02/97/24/51/1000_F_297245133_gBPfK0h10UM3y7vfoEiBC3ZXt559KZar.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value){
          emit(SocialCreateUserSuccessState());
    })
        .catchError((error){
          emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPassword= true ;
  void changePasswordVisibility (){
    isPassword=! isPassword ;
    suffix =isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined ;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
