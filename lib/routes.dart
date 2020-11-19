import 'package:flutter/material.dart';
import 'package:pharmacare_app/screens/cart/cart_screen.dart';
import 'package:pharmacare_app/screens/checkout/checkout_screen.dart';
import 'package:pharmacare_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:pharmacare_app/screens/details/details_screen.dart';
import 'package:pharmacare_app/screens/forget_password/forget_password_screen.dart';
import 'package:pharmacare_app/screens/home/home_screen.dart';
import 'package:pharmacare_app/screens/orders/orders_screen.dart';
import 'package:pharmacare_app/screens/profile/profile_screen.dart';
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
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  CheckoutScreen.routeName: (context) => CheckoutScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  OrdersScreen.routeName: (context) => OrdersScreen(),
};
