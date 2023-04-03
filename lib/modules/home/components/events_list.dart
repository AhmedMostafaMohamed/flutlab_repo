import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business/blocs/event/event_bloc.dart';
import '../../../data/models/event.dart';
import '../../event/event.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EventLoaded) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.events.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(state.events[index].name),
                  subtitle: Text(state.events[index].description),
                  onTap: () {
                    Navigator.of(context).push<void>(EventDetails.route(
                        state.events[index], state.events[index].id));
                  },
                ),
              );
            },
          );
        }
        return const Center(
          child: Text('Something went wrong'),
        );
      },
    );
  }
}
