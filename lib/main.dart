import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_layout.dart';
import 'package:shop_app/modules/starter/login/login_screen.dart';
import 'package:shop_app/modules/starter/onboarding/onboarding_screen.dart';

import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cubits/app/app_cubit.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  DioHelper.init();
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final bool isOnBoarding = CachHelper.getBool(key: CachKey.isOnBoard);
  final bool isLogin =
      (CachHelper.getString(key: CachKey.userToken) ?? "").isNotEmpty;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          print(CachHelper.getToken());
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            themeMode: cubit.isDarktMod ? ThemeMode.dark : ThemeMode.light,
            home: Directionality(
              textDirection:
                  cubit.isRtl ? TextDirection.rtl : TextDirection.ltr,
              child: homeWidget(),
            ),
          );
        },
      ),
    );
  }

  Widget homeWidget() {
    if (isOnBoarding) {
      if (isLogin) {
        return const ShopLayout();
      } else {
        return LoginScreen();
      }
    } else {
      return OnBoardingScreen();
    }
  }
}
