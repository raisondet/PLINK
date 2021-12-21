import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plink/components/custom_surfix_icon.dart';
import 'package:plink/components/default_button.dart';
import 'package:plink/components/form_error.dart';
import 'package:plink/screens/otp/otp_screen.dart';
import 'package:plink/constants.dart';
import 'package:plink/size_config.dart';
import 'package:smart_select/smart_select.dart';
import 'package:plink/choices.dart' as choices;

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;

  String imgDefaultPath = "assets/images/default_profile.png";
  File? _imageFile;

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future<void> getImageFromGallery() async {
    try {
      final imageFile =
          await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildProfilePic(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildNickNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDateOfBirthFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildGenderSelect(),
          const Divider(indent: 20),
          buildInterestSelect(),
          const Divider(indent: 20),
          buildAboutMe(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "계속", //"continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, OtpScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildProfilePic() {
    //final image = NetworkImage(
    //    'https://p.kindpng.com/picc/s/451-4517876_default-profile-hd-png-download.png');

    final defaultImg = AssetImage(imgDefaultPath);
    return SizedBox(
      height: 160,
      width: 160,
      child: Stack(
        /*fit: StackFit.expand,
        clipBehavior: Clip.none,*/
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: _imageFile == null
                ? Image.asset(imgDefaultPath, fit: BoxFit.fill)
                : Image.file(
                    File(_imageFile!.path),
                    height: 160,
                    width: 160,
                    fit: BoxFit.fill,
                  ),
          ),
          Positioned(
            right: 5,
            bottom: 5,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white, width:3),
                  ),
                  primary: Colors.white,
                  backgroundColor: kPrimaryColor,
                ),
                onPressed: getImageFromGallery,
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGenderSelect() {
    String value = 'flutter';
    return SmartSelect<String>.single(
      title: '성별 (optional)', //'Gender (optional)',
      value: value,
      choiceItems: choices.genders,
      modalType: S2ModalType.bottomSheet,
      onChange: (state) {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() => value = state.value);
      },
      tileBuilder: (context, state) => S2Tile.fromState(
        state,
        isTwoLine: true,
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: const Icon(Icons.label_outline),
        ),
      ),
    );
  }

  Widget buildInterestSelect() {
    List<String> _interests = [];
    String value = 'flutter';
    return SmartSelect<String>.multiple(
      title: '관심사 (optional)',//'Interests (optional)',
      onChange: (selected) {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() => _interests = selected.value);
      },
      choiceType: S2ChoiceType.chips,
      choiceItems: S2Choice.listFrom<String, Map>(
        source: choices.interests,
        value: (index, item) => item['id'],
        title: (index, item) => item['name'],
      ),
      modalConfig: S2ModalConfig(
        type: S2ModalType.bottomSheet,
        useFilter: true,
      ),
      tileBuilder: (context, state) => S2Tile.fromState(
        state,
        isTwoLine: true,
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: const Icon(Icons.workspaces_outline),
        ),
      ),
    );
  }

  Widget buildAboutMe() {
    List<String> _features = [];
    return SmartSelect<String>.multiple(
      title: '나를 표현하는 태그 (optional)',//'About Me (optional)',
      onChange: (selected) {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() => _features = selected.value);
      },
      choiceType: S2ChoiceType.chips,
      choiceItems: S2Choice.listFrom<String, Map>(
        source: choices.features,
        value: (index, item) => item['id'],
        title: (index, item) => item['name'],
      ),
      modalConfig: S2ModalConfig(
        type: S2ModalType.bottomSheet,
        useFilter: true,
      ),
      tileBuilder: (context, state) => S2Tile.fromState(
        state,
        isTwoLine: true,
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: const Icon(Icons.assignment_ind_outlined),
        ),
      ),
      /*tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          isTwoLine: true,
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://source.unsplash.com/xsGxhtAsfSA/100x100',
            ),
          ),
        );
      },*/
    );
  }

  TextFormField buildDateOfBirthFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDateBirthNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kDateBirthNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "생년월일", //""Date of Birth",
        hintText: "2000.12.25",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Heart Icon_2.svg"),
      ),
    );
  }

  TextFormField buildNickNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "ID",//Nickname",
        hintText: "아이디 입력",//"Enter your nickname",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

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
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "전화번호 입력",//"Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }
}
