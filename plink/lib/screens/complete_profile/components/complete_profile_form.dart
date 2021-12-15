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
          buildDateOfBirthFormField(),
          /*
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          */
          SizedBox(height: getProportionateScreenHeight(30)),
          buildGenderSelect(),
          const Divider(indent: 20),
          buildInterestSelect(),
          const Divider(indent: 20),
          buildAboutMe(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
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
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            //radius: 16.0,
            child: ClipOval(
              child: _imageFile == null
                  ? Text('no image')
                  : Image.file(File(_imageFile!.path)),
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
                    side: BorderSide(color: Colors.white),
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
    List<S2Choice<String>> options = [
      S2Choice<String>(value: 'm', title: 'male'),
      S2Choice<String>(value: 'f', title: 'female'),
      S2Choice<String>(value: 'o', title: 'others'),
    ];

    return SmartSelect<String>.single(
      title: 'Gender',
      value: value,
      choiceItems: options,
      modalType: S2ModalType.bottomSheet,
      onChange: (state) => setState(() => value = state.value),
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
    List<String> _smartphone = [];
    String value = 'flutter';

    List<Map<String, dynamic>> smartphones = [
      {
        'id': 'sk3',
        'name': 'Samsung Keystone 3',
        'brand': 'Samsung',
        'category': 'Budget Phone'
      },
      {
        'id': 'n106',
        'name': 'Nokia 106',
        'brand': 'Nokia',
        'category': 'Budget Phone'
      },
      {
        'id': 'n150',
        'name': 'Nokia 150',
        'brand': 'Nokia',
        'category': 'Budget Phone'
      },
      {
        'id': 'r7a',
        'name': 'Redmi 7A',
        'brand': 'Xiaomi',
        'category': 'Mid End Phone'
      },
      {
        'id': 'ga10s',
        'name': 'Galaxy A10s',
        'brand': 'Samsung',
        'category': 'Mid End Phone'
      },
      {
        'id': 'rn7',
        'name': 'Redmi Note 7',
        'brand': 'Xiaomi',
        'category': 'Mid End Phone'
      },
      {
        'id': 'ga20s',
        'name': 'Galaxy A20s',
        'brand': 'Samsung',
        'category': 'Mid End Phone'
      },
      {
        'id': 'mc9',
        'name': 'Meizu C9',
        'brand': 'Meizu',
        'category': 'Mid End Phone'
      },
      {
        'id': 'm6',
        'name': 'Meizu M6',
        'brand': 'Meizu',
        'category': 'Mid End Phone'
      },
    ];

    return SmartSelect<String>.multiple(
      title: 'Interests',
      onChange: (selected) {
        setState(() => _smartphone = selected.value);
      },
      choiceType: S2ChoiceType.chips,
      choiceItems: S2Choice.listFrom<String, Map>(
        source: smartphones,
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
    List<String> _smartphone = [];
    String value = 'flutter';

    List<Map<String, dynamic>> smartphones = [
      {
        'id': 'sk3',
        'name': 'Samsung Keystone 3',
        'brand': 'Samsung',
        'category': 'Budget Phone'
      },
      {
        'id': 'n106',
        'name': 'Nokia 106',
        'brand': 'Nokia',
        'category': 'Budget Phone'
      },
      {
        'id': 'n150',
        'name': 'Nokia 150',
        'brand': 'Nokia',
        'category': 'Budget Phone'
      },
      {
        'id': 'r7a',
        'name': 'Redmi 7A',
        'brand': 'Xiaomi',
        'category': 'Mid End Phone'
      },
      {
        'id': 'ga10s',
        'name': 'Galaxy A10s',
        'brand': 'Samsung',
        'category': 'Mid End Phone'
      },
      {
        'id': 'rn7',
        'name': 'Redmi Note 7',
        'brand': 'Xiaomi',
        'category': 'Mid End Phone'
      },
      {
        'id': 'ga20s',
        'name': 'Galaxy A20s',
        'brand': 'Samsung',
        'category': 'Mid End Phone'
      },
      {
        'id': 'mc9',
        'name': 'Meizu C9',
        'brand': 'Meizu',
        'category': 'Mid End Phone'
      },
      {
        'id': 'm6',
        'name': 'Meizu M6',
        'brand': 'Meizu',
        'category': 'Mid End Phone'
      },
    ];

    return SmartSelect<String>.multiple(
      title: 'About Me',
      onChange: (selected) {
        setState(() => _smartphone = selected.value);
      },
      choiceType: S2ChoiceType.chips,
      choiceItems: S2Choice.listFrom<String, Map>(
        source: smartphones,
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
        hintText: "Enter your phone address",
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
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildDateOfBirthFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration(
        labelText: "Date of Birth",
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
        labelText: "Nickname",
        hintText: "Enter your nickname",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
