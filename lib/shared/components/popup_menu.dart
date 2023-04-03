import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoner_tag/business/cubits/group_page/group_page_cubit.dart';

// This is the type used by the popup menu below.
enum SampleItem { itemOne, itemTwo, itemThree }

class PopupMenuExample extends StatefulWidget {
  final String eventId;
  final String groupName;
  const PopupMenuExample(
      {super.key, required this.eventId, required this.groupName});

  @override
  State<PopupMenuExample> createState() => _PopupMenuExampleState();
}

class _PopupMenuExampleState extends State<PopupMenuExample> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      // Callback that sets the selected popup menu item.
      onSelected: (SampleItem item) {
        setState(() {
          selectedMenu = item;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: Text('Delete group'),
          onTap: () {
            context
                .read<GroupPageCubit>()
                .deleteGroup(widget.eventId, widget.groupName);
          },
        ),
      ],
    );
  }
}
