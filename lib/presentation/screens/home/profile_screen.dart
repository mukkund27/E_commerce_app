import 'package:e_com/logic/cubit/user_cubit/user_cubit.dart';
import 'package:e_com/logic/cubit/user_cubit/user_state.dart';
import 'package:e_com/presentation/screens/user/edit_profile.dart';
import 'package:e_com/presentation/widgets/link_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ui.dart';
import '../../../data/Model/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      bloc: UserCubit(),
      builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is UserLoggedInState) {
          return userProfile(user: state.userModel);
        }
        return const Center(
          child: Text("An Error occurred!"),
        );
      },
    );
  }

  Widget userProfile({required UserModel user}) {
    print(user.fullName);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user.fullName}",
              style: TextStyles.heading3.copyWith(color: Colors.black),
            ),
            Text(
              "${user.email}",
              style: TextStyles.body2.copyWith(color: Colors.black),
            ),
            LinkButton(
              text: "Edit Profile",
              onPressed: () {
                Navigator.pushNamed(context, EditProfileScreen.routeName);
              },
            ),
          ],
        ),
        const Divider(),
        ListTile(onTap: () {

        },
          title: const Text("My Order"),contentPadding: EdgeInsets.zero,
          leading: const Icon(CupertinoIcons.cube_box_fill),
        ),
        ListTile(onTap: () {
          BlocProvider.of<UserCubit>(context).signOut();
        },
          title: const Text("Sign Out"),contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.exit_to_app,color: Colors.red,),
        ),
      ],
    );
  }
}
