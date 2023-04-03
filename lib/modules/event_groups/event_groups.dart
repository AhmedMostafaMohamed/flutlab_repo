import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoner_tag/data/models/child.dart';
import 'package:schoner_tag/data/models/group.dart';

import '../../business/blocs/group/group_bloc.dart';
import '../../data/models/user.dart';
import '../../data/repositories/group/group_repository.dart';
import '../../shared/components/my_textfield.dart';
import 'components/choose_subscribers.dart';
import 'components/group_page.dart';

class EventGroups extends StatelessWidget {
  final String eventId;
  final newGroupName = TextEditingController();
  final newGroupLocation = TextEditingController();
  EventGroups({super.key, required this.eventId});
  static Route route(String id) {
    return MaterialPageRoute<void>(
        builder: (_) => EventGroups(
              eventId: id,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupBloc(groupRepository: GroupRepository())
        ..add(LoadGroups(eventId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Event groups')),
        body: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            if (state is GroupsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GroupsLoaded) {
              return SingleChildScrollView(
                child: Column(children: [
                  MaterialButton(
                      child: Row(children: const [
                        Icon(
                          Icons.add,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'New group',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ]),
                      onPressed: () async {
                        final snapshot = await FirebaseFirestore.instance
                            .collection('events')
                            .doc(eventId)
                            .collection('subscribers')
                            .get();
                        final List<Child> children = [];
                        snapshot.docs.forEach(
                          (element) {
                            children.add(Child.fromSnapshot(element));
                          },
                        );
                        Navigator.of(context).push<void>(
                            ChooseSubscribers.route(children, eventId));
                      }),
                  MaterialButton(
                      child: Row(children: const [
                        Icon(
                          Icons.timelapse_sharp,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Waiting list',
                          style: TextStyle(fontSize: 20),
                        )
                      ]),
                      onPressed: () {}),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 500,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.groups.length,
                        itemBuilder: (context, index) {
                          return MaterialButton(
                              child: Row(children: [
                                Icon(
                                  Icons.group,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${state.groups[index].name}',
                                  style: TextStyle(fontSize: 20),
                                )
                              ]),
                              onPressed: () {
                                Navigator.of(context).push<void>(
                                    GroupPage.route(
                                        state.groups[index], eventId));
                              });
                        },
                      ),
                    ),
                  ),
                ]),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
