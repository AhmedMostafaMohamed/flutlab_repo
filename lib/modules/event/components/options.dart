import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:schoner_tag/data/models/child.dart';

import '../../../data/models/user.dart' as my_user;
import '../../../shared/components/my_button.dart';
import '../../event_groups/event_groups.dart';
import 'instructors.dart';
import '../../event_subscribers/manage_subscribers.dart';

class OptionsBottomSheet extends StatelessWidget {
  final id;
  const OptionsBottomSheet({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyButton(
              onPressed: () async {
                Navigator.pop(context);
                Navigator.of(context).push<void>(ManageSubscibers.route(
                  id,
                ));
              },
              buttonText: 'Manage subscribers'),
          MyButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push<void>(EventGroups.route(id));
              },
              buttonText: 'Event groups'),
          MyButton(
              onPressed: () async {
                final snapshot = await FirebaseFirestore.instance
                    .collection('events')
                    .doc(id)
                    .collection('instructors')
                    .get();
                final List<my_user.User> users = [];
                snapshot.docs.forEach(
                  (element) {
                    users.add(my_user.User.fromMap(element.data()));
                  },
                );
                Navigator.pop(context);

                Navigator.of(context).push<void>(Instructors.route(id, users));
              },
              buttonText: 'Manage instructors'),
          MyButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('events')
                    .doc(id)
                    .collection('instructors')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({
                  'name': FirebaseAuth.instance.currentUser!.displayName,
                  'email': FirebaseAuth.instance.currentUser!.email,
                  'UserId': FirebaseAuth.instance.currentUser!.uid,
                });
                Navigator.pop(context);
              },
              buttonText: 'Join as an instructor')
        ],
      ),
    );
  }
}
