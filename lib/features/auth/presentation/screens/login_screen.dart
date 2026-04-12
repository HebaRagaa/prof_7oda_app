

// auth/presentation/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prof_7oda_app/core/helpers/shared_pref_helper.dart';
import 'package:prof_7oda_app/core/widgets/custom_button.dart';
import 'package:prof_7oda_app/features/auth/domain/entities/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccess) {
              // 🔥 1. نطبع التوكن (علشان نتأكد)
              print("Token: ${state.user.token}");

              // 🔥 2. نحفظ التوكن
              await SharedPrefHelper.setToken(state.user.token);

              // 🔥 3. نروح للهوم
              // 🔥 Navigation
              Navigator.pushReplacementNamed(context, '/products');
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: "username"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                const SizedBox(height: 20),

                CustomButton(
                  text: "Login",
                  isLoading: state is AuthLoading,
                  onPressed: () {
                    context.read<AuthCubit>().login(
                      usernameController.text,
                      passwordController.text,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


