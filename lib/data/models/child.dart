import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Child extends Equatable {
  final String? name;
  final DateTime? dob;
  final String? languageLevel;
  final String? gender;
  String? parentId;
  bool isSelected;

  Child({
    this.isSelected = false,
    required this.name,
    required this.dob,
    required this.languageLevel,
    required this.gender,
    this.parentId = '0',
  });
  static Child fromSnapshot(DocumentSnapshot snap) {
    Child child = Child(
        name: snap['child']['name'],
        dob: DateTime.fromMillisecondsSinceEpoch(snap['child']['dob']),
        languageLevel: snap['child']['languageLevel'],
        gender: snap['child']['gender'],
        parentId: snap['child']['parentId']);
    return child;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dob': dob!.millisecondsSinceEpoch,
      'languageLevel': languageLevel,
      'gender': gender,
      'parentId': parentId,
    };
  }

  @override
  List<Object?> get props => [name, dob, languageLevel, gender, parentId];
}
