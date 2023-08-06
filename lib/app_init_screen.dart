import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_firebase/application_screen.dart';
import 'package:todo_app_with_firebase/auth/logic/bloc/auth_bloc.dart';
import 'package:todo_app_with_firebase/auth/presentation/login_screen.dart';
import 'package:todo_app_with_firebase/shared/app_routes.dart';

class AppInitScreen extends StatefulWidget {
  const AppInitScreen({super.key});

  @override
  State<AppInitScreen> createState() => _AppInitScreenState();
}

class _AppInitScreenState extends State<AppInitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.errorCheckingAuthState) {
            setRoot(
              context,
              const LoginScreen(),
            );
          }
          if (state.successCheckingAuthState) {
            setRoot(
              context,
              const ApplicationScreen(),
            );
          }
        },
        child: const Center(
          child: CupertinoActivityIndicator(
            radius: 50,
          ),
        ),
      ),
    );
  }
}
