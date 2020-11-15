import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pharmacare_app/components/custom_surfix_icon.dart';
import 'package:pharmacare_app/components/default_button.dart';
import 'package:pharmacare_app/components/form_error.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/models/api.dart';
import 'package:pharmacare_app/screens/forget_password/forget_password_screen.dart';
import 'package:pharmacare_app/screens/home/home_screen.dart';
import 'package:pharmacare_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  bool _isLoading = false;
  final List<String> errors = [];

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
          buildEmailFormField(),
          SizedBox(height: getProportationateScreenHeight(20)),
          buildPasswordFormField(),
          // SizedBox(height: getProportationateScreenHeight(15)),
          FormError(errors: errors),
          Row(
            children: [
              Checkbox(
                  value: remember,
                  activeColor: kPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value;
                    });
                  }),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.popAndPushNamed(
                    context, ForgetPasswordScreen.routeName),
                child: Text(
                  "Forget Password",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: getProportationateScreenHeight(20)),
          DefaultButton(
            text: _isLoading ? 'Processing...' : "Login",
            press: _isLoading
                ? null
                : () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if (errors.length == 0) {
                        _login();
                      }
                    }
                  },
          )
        ],
      ),
    );
  }

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

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'email': email,
      'password': password,
    };

    var endPoint = '/auth/login';
    var response = await Network().postRequest(data, endPoint);
    var body = json.decode(response.body);

    if (body['status_code'] == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      // //save token
      localStorage.setString("token", body['access_token']);
      // //save user
      localStorage.setString("user", json.encode(body['user']));

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

    setState(() {
      _isLoading = false;
    });
  }
}
