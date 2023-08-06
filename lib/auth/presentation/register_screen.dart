import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app_with_firebase/application_screen.dart';
import 'package:todo_app_with_firebase/auth/data/auth_services.dart';
import 'package:todo_app_with_firebase/auth/logic/bloc/auth_bloc.dart';
import 'package:todo_app_with_firebase/shared/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _firstNamedController;
  late TextEditingController _lastNamedController;
  late AuthServices _authServices;

  File? _image;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNamedController = TextEditingController();
    _lastNamedController = TextEditingController();
    _authServices = AuthServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: AutofillGroup(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.errorLoading) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      "${state.message}",
                    )),
                  );
                }

                if (state.successLoading) {
                  setRoot(context, const ApplicationScreen());
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 83,
                          backgroundColor: Colors.white,
                        ),
                        CircleAvatar(
                          backgroundImage:
                              _image != null ? FileImage(_image!) : null,
                          radius: 80,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 20,
                          child: IconButton(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              var image = await picker.pickImage(
                                  source: ImageSource.gallery);

                              if (image != null) {
                                setState(() {
                                  _image = File(image.path);
                                });
                              }
                            },
                            icon: const Icon(Icons.camera_alt),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _firstNamedController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        label: Text("First Name"),
                        hintText: 'Your first name',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _lastNamedController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        label: Text("Last Name"),
                        hintText: 'Your last name',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autofillHints: const [AutofillHints.email],
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        hintText: 'Your email',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        label: Text("Password"),
                        hintText: 'Your password',
                      ),
                      autofillHints: const [AutofillHints.password],
                    ),
                    const SizedBox(height: 15),
                    Text.rich(
                      TextSpan(
                        text: 'Alredy have an Account? ',
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                          ),
                        ],
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 50),
                    OutlinedButton(
                      onPressed: () async {
                        var imageUrl;
                        if (_image != null) {
                          try {
                            imageUrl = await _authServices
                                .uploadFileToFirestore(_image!);
                          } catch (e) {
                            print(e);
                          }
                        }

                        context.read<AuthBloc>().add(
                              RegisterEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                fisrtName: _firstNamedController.text,
                                lastName: _lastNamedController.text,
                                image: imageUrl ?? '',
                              ),
                            );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state.isLoading
                              ? const CupertinoActivityIndicator()
                              : const Text('Register'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
