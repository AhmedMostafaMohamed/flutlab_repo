import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../data/models/user.dart' as my_user;
import '../event.dart';

class Instructors extends StatefulWidget {
  final List<my_user.User> users;
  final String eventId;
  static Route route(String eventId, List<my_user.User> users) {
    return MaterialPageRoute<void>(
        builder: (_) => Instructors(
              eventId: eventId,
              users: users,
            ));
  }

  const Instructors({super.key, required this.users, required this.eventId});
  @override
  _InstructorsState createState() => _InstructorsState();
}

class _InstructorsState extends State<Instructors> {
  List<my_user.User> selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage instructors')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: widget.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return item
                    return usersItem(
                        widget.users[index].name,
                        widget.users[index].isSelected,
                        widget.users[index].id,
                        index,
                        widget.users[index].email);
                  }),
            ),
            selectedUsers.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        color: Colors.green[700],
                        child: Text(
                          "Delete (${selectedUsers.length})",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () async {
                          for (my_user.User user in selectedUsers) {
                            await FirebaseFirestore.instance
                                .collection('events')
                                .doc(widget.eventId)
                                .collection('instructors')
                                .doc(user.id)
                                .delete();
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget usersItem(
      String? name, bool isSelected, String? id, int index, String? email) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green[700],
        child: Icon(
          Icons.person_outline_outlined,
          color: Colors.white,
        ),
      ),
      title: Text(
        name!,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(email!),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Colors.green[700],
            )
          : Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          widget.users[index].isSelected = !widget.users[index].isSelected;
          if (widget.users[index].isSelected == true) {
            selectedUsers.add(my_user.User(
              name: name,
              email: email,
              id: id,
              isSelected: true,
            ));
          } else if (widget.users[index].isSelected == false) {
            selectedUsers.removeWhere(
                (element) => element.name == widget.users[index].name);
          }
        });
      },
    );
  }
}
