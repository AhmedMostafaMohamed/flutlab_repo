import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoner_tag/shared/components/my_button.dart';
import 'package:schoner_tag/shared/components/my_textfield.dart';

import '../../data/models/event.dart';
import '../../shared/components/image_helper.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final dateController = TextEditingController();
  final name = TextEditingController();
  final description = TextEditingController();
  final location = TextEditingController();
  final maximum = TextEditingController();
  String imageUrl = '';
  File? _image;
  String selectedValue = 'Public';
  List<String> privacy = ['Public', 'Private'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loadImage('E'),
                myDropDown(items: privacy),
                const SizedBox(height: 20),
                MyTextField(
                  controller: name,
                  hintText: 'Event name',
                  obscureText: false,
                  prefixIcon: Icon(Icons.event),
                  onChanged: (p0) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: location,
                  hintText: 'Location',
                  obscureText: false,
                  prefixIcon: Icon(Icons.location_on_outlined),
                  onChanged: (p0) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 170,
                      child: MyTextField(
                        controller: dateController,
                        hintText: 'schedule',
                        obscureText: false,
                        readOnly: true,
                        prefixIcon: const Icon(Icons.calendar_month_outlined),
                        onTap: _showDatePicker,
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: MyTextField(
                        controller: maximum,
                        hintText: 'Max entries',
                        obscureText: false,
                        type: TextInputType.number,
                        prefixIcon: const Icon(Icons.numbers),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: description,
                  hintText: 'Description',
                  obscureText: false,
                  maxLines: 4,
                  prefixIcon: Icon(Icons.description),
                  onChanged: (p0) {},
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String id =
                await FirebaseFirestore.instance.collection('events').doc().id;

            await FirebaseFirestore.instance.collection('events').doc(id).set({
              'userID': FirebaseAuth.instance.currentUser!.uid,
              'event': Event(
                      name: name.text,
                      description: description.text,
                      date: dateController.text,
                      location: location.text,
                      maxEntries: int.parse(maximum.text),
                      privacy: selectedValue,
                      imageUrl: imageUrl)
                  .toMap()
            });
          },
          child: Icon(Icons.add)),
    );
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateUtils.dateOnly(DateTime.now()),
            firstDate: DateUtils.dateOnly(DateTime.now()),
            lastDate: DateUtils.dateOnly(DateTime(2025)))
        .then((value) {
      setState(() {
        if (value != null) {
          dateController.text = '${value.year}/${value.month}/${value.day}';
        } else {
          dateController.text = '';
        }
      });
    });
  }

  Widget myDropDown({required List<String> items}) {
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
                'Select privacy',
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
    );
  }

  Widget loadImage(String initials) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.contain,
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 64,
            foregroundImage: _image != null ? FileImage(_image!) : null,
            child: Text(
              initials,
              style: const TextStyle(fontSize: 48),
            ),
          ),
        ),
        TextButton(
            onPressed: () async {
              final imageHelper = ImageHelper();
              final files = await imageHelper.pickImage();
              String uniqueFileName =
                  DateTime.now().millisecondsSinceEpoch.toString();
              if (files.isNotEmpty) {
                setState(() {
                  _image = File(files.first.path);
                });
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);
                try {
                  await referenceImageToUpload.putFile(_image!);
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (e) {
                  print(e);
                }
              }
            },
            child: const Text('Select an image'))
      ],
    );
  }
}
