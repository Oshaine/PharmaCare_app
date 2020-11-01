import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pharmacare_app/api/api.dart';
import 'package:pharmacare_app/components/custom_surfix_icon.dart';
import 'package:pharmacare_app/components/default_button.dart';
import 'package:pharmacare_app/components/form_error.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/screens/home/home_screen.dart';
import 'package:pharmacare_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  String email;
  String password;
  String confirmPassword;

  bool _isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportationateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportationateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportationateScreenHeight(30)),
          buildConfirmPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportationateScreenHeight(30)),
          DefaultButton(
            text: _isLoading ? "Processing..." : "Create Account",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (errors.length == 0) {
                  _register();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  //Email Field
  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Email",
          hintText: "Enter your email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Mail.svg",
          )),
    );
  }

  //Password Field
  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kShortPassError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kPassNullError);
          return "";
        }
        password = value;
        return null;
      },
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          )),
    );
  }

  //Confirm Password
  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (password == confirmPassword) {
          removeError(error: kMatchPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          return "";
        } else if (password != value) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Confirrm Password",
          hintText: "Confirm your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          )),
    );
  }

  //get sharedpreference data
  void getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    firstName = localStorage.getString('first_name');
    lastName = localStorage.getString('last_name');
    phoneNumber = localStorage.getString('phone_number');
    address = localStorage.getString('address');
  }

//register
  void _register() async {
    setState(() {
      _isLoading = true;
    });

    getData();

    var data = {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'address': address,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword
    };

    try {
      var endPoint = "/auth/register";
      var response = await Network().postRequest(data, endPoint);
      var body = json.decode(response.body);

      if (body['data']['original']['status_code'] == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        //save token
        localStorage.setString(
            "token", body['data']['original']['access_token']);
        //save user
        localStorage.setString(
            "user", json.encode(body['data']['original']['user']));

        Navigator.popAndPushNamed(context, HomeScreen.routeName);
      } else {
        var message = body['message'] != ""
            ? body['message']
            : 'Something happened. Ensure you fill out all fields';
        Flushbar(
          message: message,
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } catch (e) {
      Flushbar(
        message: "Something happened, Try again later",
        duration: Duration(seconds: 3),
      )..show(context);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
