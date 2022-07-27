import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.model.status) {
              showToast(text: state.model.message, backgroundColor: Colors.green);
            } else {
              showToast(text: state.model.message, backgroundColor: Colors.red);
            }
          } else if (state is LoginErrorState) {
            showToast(text: state.error, backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 30),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Email must not be empty";
                            }
                            return null;
                          },
                          label: "Email",
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                          isPassword: cubit.isSecure,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Email must not be empty";
                            }
                            return null;
                          },
                          suffixPressed: () {
                            cubit.isSecure = !cubit.isSecure;
                          },
                          label: "Password",
                          suffix: cubit.isSecure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          prefix: Icons.lock_outline,
                          onSubmit: (_) {
                            login(cubit);
                          },
                        ),
                        const SizedBox(height: 25),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (BuildContext context) => defaultButton(
                            function: () {
                              login(cubit);
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Don\'t have account?'),
                              defaultTextButton(
                                'Register',
                                () =>
                                    navigateTo(context, const RegisterScreen()),
                              ),
                            ],
                          ),
                        )
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

  void login(LoginCubit cubit) {
    if (formKey.currentState!.validate()) {
      cubit.login(
        emailController.text,
        passwordController.text,
      );
    }
  }
}
