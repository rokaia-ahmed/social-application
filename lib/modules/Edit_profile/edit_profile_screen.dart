
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/Components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';


class EditProfileScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:(context,state){
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text =userModel!.name!;
        bioController.text =userModel.bio!;
        phoneController.text =userModel.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit profile'),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            titleSpacing: 5.0,
            actions: [
              TextButton(
                onPressed:(){
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                child:Text('update'),
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height:190.0 ,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight:Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage!= null ? FileImage(coverImage) : NetworkImage(
                                        '${userModel.cover}') as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ) ,
                              ),
                              IconButton(
                                  onPressed:(){
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    radius:20.0 ,
                                      child: Icon(
                                          IconBroken.Camera,
                                       size:16.0 ,
                                      ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage != null ? FileImage(profileImage) : NetworkImage('${userModel.image}') as ImageProvider ,
                              ),
                            ),
                            IconButton(
                              onPressed:(){
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                radius:20.0 ,
                                child: Icon(
                                  IconBroken.Camera,
                                  size:16.0 ,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).profileImage != null ||SocialCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if(SocialCubit.get(context).profileImage != null)
                      Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  text:'upload profile',
                                  function:(){
                                    SocialCubit.get(context).uploadProfileImage(
                                        name:nameController.text,
                                        phone:phoneController.text,
                                        bio: bioController.text,
                                    );
                                  }
                              ),
                              if(state is SocialUserUpdateLoadingState)
                              SizedBox(
                                height: 5.0,
                              ),
                              if(state is SocialUserUpdateLoadingState)
                              LinearProgressIndicator(),
                            ],
                          ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if(SocialCubit.get(context).coverImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                text:'upload cover ',
                                function:(){
                                  SocialCubit.get(context).uploadCoverImage(
                                    name:nameController.text,
                                    phone:phoneController.text,
                                    bio: bioController.text,
                                  );
                                }
                            ),
                            if(state is SocialUserUpdateLoadingState)
                            SizedBox(
                              height: 5.0,
                            ),
                            if(state is SocialUserUpdateLoadingState)
                            LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).profileImage != null ||SocialCubit.get(context).coverImage != null)
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate:(value){
                        if(value.isEmpty){
                          return 'name must not be empty';
                        }
                        return null;
                      } ,
                      label:'Name',
                      prefix: IconBroken.User,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate:(value){
                      if(value.isEmpty){
                        return 'bio must not be empty';
                      }
                      return null;
                    } ,
                    label:'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate:(value){
                      if(value.isEmpty){
                        return 'phone number must not be empty';
                      }
                      return null;
                    } ,
                    label:'phone',
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ) ,
        );
      } ,

    );
  }
}
