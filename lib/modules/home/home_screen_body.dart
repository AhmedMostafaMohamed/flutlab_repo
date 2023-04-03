import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoner_tag/data/models/event.dart';

import 'components/events_list.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});
  static Page page() => const MaterialPage<void>(child: HomeScreenBody());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FirebaseAuth.instance.currentUser!.displayName != null
                      ? 'Hi, ${FirebaseAuth.instance.currentUser!.displayName} 👋'
                      : '',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const CircleAvatar(child: Icon(Icons.person))
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            const EventList(),
          ],
        ),
      ),
    );
  }
}
