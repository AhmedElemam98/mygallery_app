import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/cubits/auth/auth_cubit.dart';
import '../../homeScreen/home_screen.dart';
import 'login_button.dart';

class LogInContainerWidget extends StatelessWidget {
  LogInContainerWidget({
    super.key,
  });
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? email, password;
    return Positioned.fill(
      top: 370.h,
      right: 28.h,
      left: 28.h,
      bottom: 45.h,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            height: 400.h,
            width: 388.w,
            decoration: BoxDecoration(
                color: Colors.white54.withOpacity(0.4),
                borderRadius: BorderRadius.circular(33.sp)),
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'LOG IN',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4A4A4A)),
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      textAlign: TextAlign.left,
                      decoration: _textFiledInputDecoration("email"),
                      controller: emailController,
                      validator: (value) {
                        String p =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(p);
                        if (value!.trim().isEmpty) {
                          return ('Enter email!');
                        } else if (!regExp.hasMatch(value.trim())) {
                          return ('Enter valid email!');
                        }
                      },
                      onSaved: (value) {
                        email = value;
                      },
                    ),
                    TextFormField(
                      decoration: _textFiledInputDecoration('password'),
                      obscureText: true,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return "password must be more 6 digit";
                        }
                      },
                      onSaved: (value) {
                        password = value;
                      },
                    ),
                    SubmitedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                    ),
                    __buildHome(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _textFiledInputDecoration(String text) {
    return InputDecoration(
        fillColor: Colors.white38,
        contentPadding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 10.h),
        filled: true,
        hintStyle: TextStyle(
          color: Colors.black45,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.sp),
          borderSide: const BorderSide(color: Colors.white38),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.sp),
          borderSide: const BorderSide(color: Colors.orange),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.sp),
          borderSide: const BorderSide(color: Colors.white60),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.sp),
          borderSide: const BorderSide(color: Colors.white),
        ),
        labelText: text);
  }

  Widget __buildHome() {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is AuthLoading) {
          showProgressIndicator(context);
        }

        if (state is AuthLoggedIn) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(user: state.user),
            ),
          );
        }

        if (state is AuthError) {
          Navigator.pop(context);
          String errorMsg = 'something has wrong try again';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }
}
