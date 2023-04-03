import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/models/child.dart';

class ChildrenList extends StatefulWidget {
  final List<Child> children;
  final String eventId;

  const ChildrenList({
    super.key,
    required this.children,
    required this.eventId,
  });
  @override
  _ChildrenListState createState() => _ChildrenListState();
}

class _ChildrenListState extends State<ChildrenList> {
  List<Child> selectedChildren = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: widget.children.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChildItem(
                      widget.children[index].name!,
                      widget.children[index].dob!,
                      widget.children[index].isSelected,
                      index,
                      widget.children[index].languageLevel!,
                      widget.children[index].gender!,
                    );
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
                          print(
                              "Delete List Lenght: ${selectedChildren.length}");
                          for (Child child in selectedChildren) {
                            await FirebaseFirestore.instance
                                .collection('events')
                                .doc(widget.eventId)
                                .collection('subscribers')
                                .doc()
                                .set({
                              'child': child.toMap(),
                              'parentId': FirebaseAuth.instance.currentUser!.uid
                            });
                          }
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

  Widget ChildItem(String name, DateTime dob, bool isSelected, int index,
      String language, String gender) {
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
                languageLevel: language,
                gender: gender));
          } else if (widget.children[index].isSelected == false) {
            selectedChildren.removeWhere(
                (element) => element.name == widget.children[index].name);
          }
        });
      },
    );
  }
}
