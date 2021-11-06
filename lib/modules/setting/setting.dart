import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/Edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/Components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';


class SettingScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context ,state){} ,
      builder:(context ,state){
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height:190.0 ,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight:Radius.circular(4.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                                '${userModel!.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ) ,
                      ),
                    ),
                    CircleAvatar(
                      radius: 65.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage:NetworkImage('${userModel.image}') ,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){} ,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '245',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){} ,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){} ,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '64',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap:(){} ,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      child: Text('Add Photos') ,
                      onPressed:(){} ,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                    child: Icon(
                      IconBroken.Edit,
                      size: 16.0,
                    ) ,
                    onPressed:(){
                      navigateTo(context,EditProfileScreen());
                    } ,
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(
                      onPressed: (){
                        FirebaseMessaging.instance.subscribeToTopic('announcing');
                      },
                      child:Text('subscribe'),
                  ),
                  SizedBox(width: 20.0,),
                  OutlinedButton(
                    onPressed: (){
                      FirebaseMessaging.instance.unsubscribeFromTopic('announcing');
                    },
                    child:Text('unsubscribe'),
                  ),
                ],
              ),
            ],
          ),
        );
      } ,

    );
  }
}
