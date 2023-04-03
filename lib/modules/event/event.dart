import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoner_tag/data/models/event.dart';
import 'package:schoner_tag/data/repositories/children/children_repository.dart';

import '../../business/blocs/children/children_bloc.dart';
import '../../data/models/child.dart';
import '../../shared/components/my_button.dart';
import 'components/instructors.dart';
import 'components/children_list.dart';
import '../event_subscribers/manage_subscribers.dart';
import '../../data/models/user.dart' as my_user;
import 'components/options.dart';

class EventDetails extends StatelessWidget {
  final Event event;
  final String id;
  bool isLoading = false;
  EventDetails({
    super.key,
    required this.event,
    required this.id,
  });

  static Route route(Event event, String id) {
    return MaterialPageRoute<void>(
        builder: (_) => EventDetails(
              event: event,
              id: id,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                context: context,
                builder: (context) => OptionsBottomSheet(
                      id: id,
                    ));
          },
        )
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  event.name,
                  style: TextStyle(fontSize: 50),
                ),
                Text(
                  event.date,
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'About ',
            style: TextStyle(fontSize: 25),
          ),
          Text(
            event.description,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
      floatingActionButton: BlocProvider(
        create: (context) =>
            ChildrenBloc(childrenRepository: ChildrenRepository())
              ..add(LoadChildren(FirebaseAuth.instance.currentUser!.uid)),
        child: BlocBuilder<ChildrenBloc, ChildrenState>(
          builder: (context, state) {
            return MyButton(
                buttonText: 'Subscribe',
                onPressed: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      if (state is ChildrenLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is ChildrenLoaded) {
                        return ChildrenList(
                          children: state.children,
                          eventId: id,
                        );
                      }
                      return Container();
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
