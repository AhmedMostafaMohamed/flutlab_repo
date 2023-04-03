import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business/blocs/group/group_bloc.dart';
import '../../../data/models/child.dart';
import '../../../data/models/user.dart' as my_user;
import '../../../shared/components/my_textfield.dart';
import 'choose_instructors.dart';

class ChooseSubscribers extends StatefulWidget {
  final List<Child> children;
  final String eventId;

  static Route route(List<Child> children, String eventId) {
    return MaterialPageRoute<void>(
        builder: (_) => ChooseSubscribers(
              children: children,
              eventId: eventId,
            ));
  }

  ChooseSubscribers({
    super.key,
    required this.children,
    required this.eventId,
  });
  @override
  _ChooseSubscribersState createState() => _ChooseSubscribersState();
}

class _ChooseSubscribersState extends State<ChooseSubscribers> {
  List<Child> selectedChildren = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('select children'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: widget.children.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return item
                    return ChildItem(
                        widget.children[index].name!,
                        widget.children[index].dob!,
                        widget.children[index].isSelected,
                        index,
                        widget.children[index].languageLevel!,
                        widget.children[index].gender!);
                  }),
            ),
            selectedChildren.isNotEmpty
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
                          "Select (${selectedChildren.length})",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () async {
                          final snapshot = await FirebaseFirestore.instance
                              .collection('events')
                              .doc(widget.eventId)
                              .collection('instructors')
                              .get();
                          final List<my_user.User> users = [];
                          snapshot.docs.forEach(
                            (element) {
                              users.add(my_user.User.fromMap(element.data()));
                            },
                          );
                          Navigator.of(context)
                              .push<void>(ChooseInstructor.route(
                                  widget.eventId, users, selectedChildren))
                              .then((value) => Navigator.of(context).pop());
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

  Widget ChildItem(
    String name,
    DateTime dob,
    bool isSelected,
    int index,
    String languageLevel,
    String gender,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green[700],
        child: Icon(
          Icons.child_care_outlined,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(dob.toString()),
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
          widget.children[index].isSelected =
              !widget.children[index].isSelected;
          if (widget.children[index].isSelected == true) {
            selectedChildren.add(Child(
              name: name,
              dob: dob,
              isSelected: true,
              languageLevel: languageLevel,
              gender: gender,
            ));
          } else if (widget.children[index].isSelected == false) {
            selectedChildren.removeWhere(
                (element) => element.name == widget.children[index].name);
          }
        });
      },
    );
  }
}
