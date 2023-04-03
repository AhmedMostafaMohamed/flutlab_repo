import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business/blocs/group/group_bloc.dart';
import '../../../data/models/child.dart';
import '../../../data/models/user.dart' as my_user;
import '../../../shared/components/my_textfield.dart';

class ChooseInstructor extends StatefulWidget {
  final List<my_user.User> users;
  final String eventId;
  final List<Child> subscribers;
  final newGroupName = TextEditingController();
  final newGroupLocation = TextEditingController();
  static Route route(
      String eventId, List<my_user.User> users, List<Child> subscribers) {
    return MaterialPageRoute<void>(
        builder: (_) => ChooseInstructor(
              eventId: eventId,
              users: users,
              subscribers: subscribers,
            ));
  }

  ChooseInstructor(
      {super.key,
      required this.users,
      required this.eventId,
      required this.subscribers});
  @override
  _ChooseInstructorState createState() => _ChooseInstructorState();
}

class _ChooseInstructorState extends State<ChooseInstructor> {
  List<my_user.User> selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('select instructors')),
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
                          "Select (${selectedUsers.length})",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('New group'),
                              content: Container(
                                height: 145,
                                child: Column(children: [
                                  MyTextField(
                                      controller: widget.newGroupName,
                                      hintText: 'name',
                                      prefixIcon: const Icon(Icons.abc),
                                      obscureText: false),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  MyTextField(
                                      controller: widget.newGroupLocation,
                                      hintText: 'location',
                                      prefixIcon: const Icon(
                                          Icons.location_on_outlined),
                                      obscureText: false)
                                ]),
                              ),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    context.read<GroupBloc>().add(CreateGroup(
                                        widget.newGroupName.text.trim(),
                                        widget.newGroupLocation.text.trim(),
                                        widget.eventId,
                                        widget.subscribers,
                                        selectedUsers));
                                    widget.newGroupLocation.text = '';
                                    widget.newGroupName.text = '';

                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('create'),
                                )
                              ],
                            ),
                          ).then((value) => Navigator.of(context).pop());
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
