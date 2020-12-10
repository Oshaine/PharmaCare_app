import 'package:flutter/material.dart';
import 'package:pharmacare_app/components/custom_surfix_icon.dart';
import 'package:pharmacare_app/components/default_button.dart';
import 'package:pharmacare_app/components/form_error.dart';
import 'package:pharmacare_app/constraints.dart';
import 'package:pharmacare_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:pharmacare_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String firstName;
  String lastName;
  String phoneNumber;
  String address;

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportationateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportationateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportationateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportationateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (errors.length == 0) {
                  saveData();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  //First Name Field
  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "First Name",
          hintText: "Enter your first name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  //Last Name Field
  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
          labelText: "Last Name",
          hintText: "Enter your last name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  //Phone Number
  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Phone Number",
          hintText: "Enter your phone number",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Phone.svg",
          )),
    );
  }

  //Address
  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Address",
          hintText: "Enter your address",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Location point.svg",
          )),
    );
  }

  void saveData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('first_name', firstName);
    localStorage.setString('last_name', lastName);
    localStorage.setString('phone_number', phoneNumber);
    localStorage.setString('address', address);

    Navigator.pushNamed(context, CompleteProfileScreen.routeName);
  }
}
