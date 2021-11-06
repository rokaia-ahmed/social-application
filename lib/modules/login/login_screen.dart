
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/Components.dart';
import 'package:social_app/shared/local/cashHelper.dart';
import 'package:social_app/layout/social_layout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if (state is SocialLoginSuccessState){
        CacheHelper.saveData
       (
       key: 'uId',
       value: state.uId,
      ). then((value) {
       navigationAndFinish(context,SocialLayout());
       });

          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5,
                        ),
                        Text('login now to communicate with your friends',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          obscureText: SocialLoginCubit
                              .get(context)
                              .isPassword,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is short';
                            }
                          },
                          onFieldSubmitted: (value) {
                            /* if(formKey.currentState!.validate()) {
                            SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }*/
                          },

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(SocialLoginCubit
                                  .get(context)
                                  .suffix),
                              onPressed: () {
                                SocialLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        BuildCondition(
                        condition: state is! SocialLoginLoadingState ,
                        builder: (context)=> Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.blue,
                          ),
                          width: double.infinity,
                          child:  MaterialButton(
                            onPressed:(){
                              print(emailController);
                              print(passwordController);
                              if(formKey.currentState!.validate()){
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password:passwordController.text);
                              }
                            },
                            child: Text('Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),

                          ),
                        ),
                        fallback: (context)=> Center(child: CircularProgressIndicator()),
                      ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account'),
                            TextButton(onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    SocialRegisterScreen(),),
                              );
                            },
                              child: Text('register now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}