import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/Components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/local/cashHelper.dart';
import 'package:social_app/shared/network/dioHelper.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/shared/styles/theme.dart';
import 'modules/login/login_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(" on background message:");
  print(message.data.toString());
  showToast(text: 'on background message', state: ToastStates.success);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  //foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message', state: ToastStates.success);
  });
  //when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message opened app', state: ToastStates.success);
  });
  //background fcm
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Widget? widget ;
   uId = CacheHelper.getData(key: 'uId')??'';
  if(uId.isNotEmpty){
    widget = SocialLayout();
  }else{
    widget = LoginScreen();
  }


  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final  Widget? startWidget ;

  MyApp(
      {
        required this.startWidget}
      );
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context)=> SocialCubit(SocialInitialState())..getUserData()..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:lightTheme ,
        home:startWidget,
      ),
    );
  }
}

