import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:schoner_tag/shared/components/my_button.dart';

import '../modules/add_event/add_screen.dart';
import '../modules/manage_children/children.dart';
import '../modules/explore/explore_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/home/home_screen_body.dart';
import '../modules/authentication/components/info.dart';

List<Widget?> NavBarPages = [
  HomeScreenBody(),
  AddScreen(),
  ExploreScreen(),
  ProfileScreen(
    children: [
      const Divider(),
      Padding(
        padding: const EdgeInsets.all(2),
        child: AspectRatio(
          aspectRatio: 1,
          child: Column(children: [
            ChildrenScreen(),
          ]),
        ),
      ),
    ],
  )
];
