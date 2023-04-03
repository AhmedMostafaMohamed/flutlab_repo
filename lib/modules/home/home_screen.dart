import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoner_tag/business/cubits/nav_bar/nav_bar_cubit.dart';

import '../../config/routes.dart';
import 'components/nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static Page page() => const MaterialPage<void>(child: HomeScreen());
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyNavBar(),
        body: NavBarPages[context
            .select((NavBarCubit cubit) => cubit.state.selectedDestination)]);
  }
}
