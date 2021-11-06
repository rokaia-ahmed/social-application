
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/newPost/new_post.dart';
import 'package:social_app/shared/components/Components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state) {
        if(state is SocialNewPostState)
          {
            navigateTo(context,NewPostScreen());
          }
      },
      builder:(context,state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:Text(
              cubit.titles[cubit.currentIndex],
            ) ,
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification),
              ),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:cubit.currentIndex ,
            onTap:(index){
              cubit.changeBottomNa(index);
            } ,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
                label: 'post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Location,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'setting',
              ),
            ],
          ),
        );
      },
    );
  }
}
