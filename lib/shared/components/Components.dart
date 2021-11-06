import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/icon_broken.dart';


Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 15.0,
  ),
  child:   Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

void navigationAndFinish(context ,widget){
  Navigator.pushReplacement(
      context, MaterialPageRoute(
      builder: (context)=> widget,
  ),
       //result: (Route <dynamic>route) => false,


  );
}
//*********************
 void showToast({
   required String text,
   required ToastStates state,
 })=>
     Fluttertoast.showToast(
     msg:text ,
     toastLength: Toast.LENGTH_LONG,
     gravity: ToastGravity.BOTTOM,
     timeInSecForIosWeb: 5,
     backgroundColor: shoosToastColor(state),
     textColor: Colors.white,
     fontSize: 16.0
 );
//enum
enum ToastStates{success, error ,warning}

Color shoosToastColor(ToastStates state){
  Color color ;
   switch(state)
      {
     case  ToastStates.success :
     color = Colors.green ;
     break;
     case  ToastStates.error :
       color = Colors.red ;
       break;
     case  ToastStates.warning:
       color = Colors.yellow ;
       break;

      }
      return color ;
}

//************************

void navigateTo( BuildContext context, Widget widget){
  Navigator.push(context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

//*********************************
Widget defaultFormField(
    {
      required controller,
      required  type,
      onSubmitt,
      onChange,
      onTap,
      bool isclickable= true,
      bool isPassword=false,
      required validate,
      required label,
      required prefix,
      suffix,
      suffixpressed,

    }
    )=>TextFormField(
  keyboardType:type,
  controller: controller,
  onFieldSubmitted: onSubmitt,
  obscureText: isPassword,
  onChanged: onChange
  ,validator:validate,
  onTap: onTap,
  enabled: isclickable,
  decoration: InputDecoration(
    labelText:label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix!=null?IconButton(
        onPressed: suffixpressed ,
        icon: Icon(suffix)):null,
    border: OutlineInputBorder(),
  ),
);
//*************************************
Widget defaultButton(
    {
      double width = double.infinity,
      Color background = Colors.blue,
      required  String text,
      required Function function,
      double radius=6.0,
      bool isUpperCase = true,
    }
    ) =>Container(
        width:width,
         height: 40.0,
       child: MaterialButton(
           onPressed:(){
             function();
    },
         child:Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: background,
  ),
);
//******************************************
 Widget defaultAppBar({
  @required BuildContext? context,
   String? title,
   List<Widget>? actions,
})=>  AppBar(
   leading:IconButton(
     onPressed: (){
       Navigator.pop(context!);
     },
      icon:Icon(
        IconBroken.Arrow___Left,
      ) ,
   ) ,
   title: Text(title!),
   actions:actions,
 );