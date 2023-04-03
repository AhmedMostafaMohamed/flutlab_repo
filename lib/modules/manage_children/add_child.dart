import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoner_tag/business/blocs/children/children_bloc.dart';
import 'package:schoner_tag/data/repositories/children/children_repository.dart';
import 'package:schoner_tag/shared/components/my_button.dart';
import 'package:schoner_tag/shared/components/my_textfield.dart';
import 'package:intl/intl.dart';
import '../../data/models/child.dart';

class AddChild extends StatefulWidget {
  AddChild({super.key});
  String selectedGender = 'Male';
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AddChild());
  }

  @override
  State<AddChild> createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  final name = TextEditingController();
  final age = TextEditingController();
  final language = TextEditingController();
  final genders = ['Male', 'Female'];
  final labels = ['bad', 'fair', 'good', 'V.good', 'Fluent'];
  DateTime? dob = DateTime.now();
  double value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a child')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: name,
                      hintText: 'Name',
                      obscureText: false,
                      prefixIcon: const Icon(Icons.child_care)),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: age,
                    hintText: 'Date of birth',
                    obscureText: false,
                    readOnly: true,
                    prefixIcon: const Icon(Icons.numbers),
                    onTap: _showDatePicker,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Language profiency level'),
                      Slider(
                        value: value,
                        min: 0,
                        max: 4,
                        divisions: 4,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue.shade100,
                        label: labels[value.toInt()],
                        onChanged: (value) => setState(() {
                          this.value = value;
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  dropDown(genders),
                ],
              ),
              MyButton(
                  onPressed: () async {
                    try {
                      final bloc = ChildrenBloc(
                          childrenRepository: ChildrenRepository());
                      Child child = Child(
                        name: name.text,
                        dob: dob!,
                        gender: widget.selectedGender,
                        languageLevel: labels[value.toInt()],
                        parentId: FirebaseAuth.instance.currentUser!.uid,
                      );
                      bloc.add(CreateChild(child));
                      await bloc.close();

                      const snackBar = SnackBar(
                        content: Text('Added successfully!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                    } catch (e) {
                      //do something when fails!
                      print(e);
                    }
                  },
                  buttonText: 'Add')
            ],
          )),
        ),
      ),
    );
  }

  Widget dropDown(
    List<String> genders,
  ) {
    return DropdownButtonHideUnderline(
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
                'Select gender',
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
        items: genders
            .map((gender) => DropdownMenuItem<String>(
                  value: gender,
                  child: Text(
                    gender,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: widget.selectedGender,
        onChanged: (value) {
          setState(() {
            widget.selectedGender = value as String;
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
          icon: const Icon(
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
    );
  }

  void _showDatePicker() {
    TextEditingController _datecontroller = new TextEditingController();

    var myFormat = DateFormat('d-MM-yyyy');

    showDatePicker(
            context: context,
            initialDate: DateUtils.dateOnly(DateTime.now()),
            firstDate: DateUtils.dateOnly(DateTime(1900)),
            lastDate: DateUtils.dateOnly(DateTime.now()))
        .then((value) {
      dob = value;
      setState(() {
        if (value != null) {
          age.text = '${value.year}/${value.month}/${value.day}';
        } else {
          age.text = '';
        }
      });
    });
  }
}
