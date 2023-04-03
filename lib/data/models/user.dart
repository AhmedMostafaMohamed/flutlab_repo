import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? email;
  final String? name;
  final String? photo;
  bool isSelected;

  User({this.isSelected = false, this.id, this.email, this.name, this.photo});
  static var empty = User(id: '');
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'email': email, 'UserId': id};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        name: map['name'] as String,
        email: map['email'] as String,
        id: map['UserId'] as String);
  }
  static User fromSnapshot(DocumentSnapshot snap) {
    User user = User(
        name: snap['user']['name'],
        email: snap['user']['email'],
        id: snap['user']['UserId']);
    return user;
  }

  @override
  List<Object?> get props => [id, email, name, photo];
}
