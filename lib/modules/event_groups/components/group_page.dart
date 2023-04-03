import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoner_tag/data/repositories/group/group_repository.dart';

import '../../../business/blocs/group/group_bloc.dart';
import '../../../business/cubits/group_page/group_page_cubit.dart';
import '../../../data/models/group.dart';

class GroupPage extends StatelessWidget {
  final Group group;
  final String eventId;
  const GroupPage({super.key, required this.group, required this.eventId});
  static Route route(Group group, String eventId) {
    return MaterialPageRoute<void>(
        builder: (_) => GroupPage(group: group, eventId: eventId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<GroupPageCubit, GroupPageState>(
          bloc: BlocProvider.of<GroupPageCubit>(context)
            ..loadChildrenAndInstructors(eventId, group.name),
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    group.location,
                    style: const TextStyle(fontSize: 21),
                  ),
                  Column(
                    children: [
                      const Text(
                        'Instructors',
                        style: TextStyle(fontSize: 20),
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.myInstructors.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(state.myInstructors[index].name!),
                                  subtitle:
                                      Text(state.myInstructors[index].email!),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Text('Subscribers', style: TextStyle(fontSize: 20)),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: 350,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.myChildren.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(state.myChildren[index].name!),
                                  subtitle: Text(
                                      state.myChildren[index].dob.toString()),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
