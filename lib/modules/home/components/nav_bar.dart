import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business/cubits/nav_bar/nav_bar_cubit.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.add_circle_outline_outlined),
              label: 'Add',
              selectedIcon: Icon(Icons.add_circle),
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              label: 'Explore',
              selectedIcon: Icon(Icons.explore),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
              selectedIcon: Icon(Icons.person),
            )
          ],
          selectedIndex: state.selectedDestination,
          onDestinationSelected: (index) =>
              context.read<NavBarCubit>().selectedDestinationChanged(index),
        );
      },
    );
  }
}
