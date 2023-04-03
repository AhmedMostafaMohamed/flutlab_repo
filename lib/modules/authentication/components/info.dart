import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoner_tag/modules/authentication/components/questions.dart';
import 'package:schoner_tag/shared/components/my_button.dart';
import 'package:schoner_tag/shared/components/my_textfield.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../home/home_screen.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final List<String> items = [
    'Parent',
    'Instructor',
  ];
  String? selectedValue;
  final controller = TextEditingController();
  final ageController = TextEditingController();
  final nameController = TextEditingController();
  String initialCountry = 'DE';
  PhoneNumber number = PhoneNumber(isoCode: 'DE');
  String? phoneNumber;

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextField(
                        controller: nameController,
                        hintText: 'Username',
                        obscureText: false,
                        prefixIcon: const Icon(Icons.person)),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: ageController,
                      hintText: 'Date of birth',
                      obscureText: false,
                      readOnly: true,
                      prefixIcon: const Icon(Icons.numbers),
                      onTap: _showDatePicker,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                        setState(() {
                          phoneNumber = number.phoneNumber as String;
                        });
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: controller,
                      formatInput: true,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: const OutlineInputBorder(),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: HexColor("#4f4f4f"),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Role',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("#4f4f4f"),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 160,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: HexColor("#f0f3f1"),
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: HexColor("#4f4f4f"),
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                            maxHeight: 200,
                            width: 200,
                            padding: null,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: HexColor("#f0f3f1"),
                            ),
                            elevation: 8,
                            offset: const Offset(-20, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            )),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ]),
            ),
      floatingActionButton: MyButton(
          buttonText: 'Next',
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            FirebaseAuth.instance.currentUser!
                .updateDisplayName(nameController.text);
            await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set({
              'email': FirebaseAuth.instance.currentUser!.email,
              'phone': phoneNumber,
              'role': selectedValue,
              'dob': ageController.text,
              'username': nameController.text
            });
            Navigator.of(context).pushReplacement(Questions.route());
          }),
    );
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateUtils.dateOnly(DateTime.now()),
            firstDate: DateUtils.dateOnly(DateTime(1900)),
            lastDate: DateUtils.dateOnly(DateTime.now()))
        .then((value) {
      setState(() {
        if (value != null) {
          ageController.text = '${value.year}/${value.month}/${value.day}';
        } else {
          ageController.text = '';
        }
      });
    });
  }
}
