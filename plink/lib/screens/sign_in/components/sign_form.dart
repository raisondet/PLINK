import 'package:flutter/material.dart';
import 'package:plink/components/custom_surfix_icon.dart';
import 'package:plink/components/form_error.dart';
import 'package:plink/components/default_button.dart';
import 'package:plink/constants.dart';
import 'package:plink/size_config.dart';
import 'package:plink/helper/keyboard.dart';
import 'package:plink/screens/forgot_password/forgot_password_screen.dart';
import 'package:plink/screens/login_success/login_success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  bool? remember = false;
  List<String?> emailErrors = [];
  List<String?> pwdErrors = [];

  void addEmailError({String? error}) {
    if (!emailErrors.contains(error))
      setState(() {
        emailErrors.add(error);
      });
  }

  void removeEmailError({String? error}) {
    if (emailErrors.contains(error))
      setState(() {
        print(error);
        emailErrors.remove(error);
        print(emailErrors);
      });
  }

  void addPwdError({String? error}) {
    if (!pwdErrors.contains(error))
      setState(() {
        pwdErrors.add(error);
      });
  }

  void removePwdError({String? error}) {
    if (pwdErrors.contains(error))
      setState(() {
        pwdErrors.remove(error);
      });
  }

  void removeAllError(){
    setState(() {
      emailErrors = [];
      pwdErrors = [];
    });
  }

  void toast(String _msg){
    Fluttertoast.showToast(
      msg: _msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: kToastBgColor,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          FormError(errors: emailErrors),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          FormError(errors: pwdErrors),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                removeAllError();
                _formKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                // if all are valid then go to success screen
                try{
                  final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null){
                    print('Login Success!!');
                    Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                    toast(kUserNotFound);
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                    toast(kWrongPassword);
                  }
                }
              }
            },
          ),
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
          if (value.length < 8){
            addPwdError(error: kShortPassError);
          }
          else{
            removePwdError(error: kShortPassError);
          }
          removePwdError(error: kPassNullError);
        } else if (value.length >= 8) {
          removePwdError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addPwdError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addPwdError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          print(value);
          if (!emailValidatorRegExp.hasMatch(value)){
            addEmailError(error: kInvalidEmailError);
          }
          else {
            removeEmailError(error: kInvalidEmailError);
          }
          removeEmailError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          print("1111");
          print(value);
          removeEmailError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addEmailError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          print(value);
          addEmailError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
