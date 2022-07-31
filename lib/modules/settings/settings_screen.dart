import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/settings/cubit/settings_cubit.dart';
import 'package:shop_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit()..getUserData(),
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsShowData) {
            print(state.userModel.name);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case SettingsLoading:
              return const Center(child: CircularProgressIndicator());
            case SettingsError:
              return Container();
            case SettingsShowData:
              return buildUserProfile(context);
            default:
              return const Center(child: Text('DEFAULT'));
          }
        },
      ),
    );
  }

  Widget buildUserProfile(BuildContext context) {

    var cubit = SettingsCubit.get(context);
    var userData = SettingsCubit.usermodel!;
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.green,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(userData.image),
              ),
            ),
          ),

          // defaultFormField(controller: ),
        ],
      ),
    );
  }
}
