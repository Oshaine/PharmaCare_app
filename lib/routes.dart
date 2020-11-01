import 'package:flutter/material.dart';
import 'package:pharmacare_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:pharmacare_app/screens/forget_password/forget_password_screen.dart';
import 'package:pharmacare_app/screens/home/home_screen.dart';
import 'package:pharmacare_app/screens/sign_in/sign_in_screen.dart';
import 'package:pharmacare_app/screens/registration/registration_screen.dart';
import 'package:pharmacare_app/screens/on_boarding/on_boarding_screen.dart';
import 'package:pharmacare_app/screens/splash/splash_screen.dart';

//all routes

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
  RegistrationScreen.routeName: (context) => RegistrationScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
