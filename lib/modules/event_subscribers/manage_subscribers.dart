import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:schoner_tag/data/models/child.dart';

class ManageSubscibers extends StatelessWidget {
  final String id;
  const ManageSubscibers({super.key, required this.id});
  static Route route(String id) {
    return MaterialPageRoute<void>(
        builder: (_) => ManageSubscibers(
              id: id,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage subscribers')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('events')
            .doc(id)
            .collection('subscribers')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data!.docs;

          return SizedBox(
            height: 400,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Child child = Child.fromSnapshot(documents[index]);

                return Card(
                  child: ListTile(
                    title: Text(child.name!),
                    subtitle: Text(child.dob.toString()),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
