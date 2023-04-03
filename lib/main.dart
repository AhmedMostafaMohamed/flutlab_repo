import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoner_tag/business/blocs/event/event_bloc.dart';
import 'package:schoner_tag/business/cubits/nav_bar/nav_bar_cubit.dart';
import 'package:schoner_tag/modules/home/home_screen.dart';
import 'package:schoner_tag/data/repositories/auth/auth_repository.dart';
import 'package:schoner_tag/data/repositories/children/children_repository.dart';
import 'package:schoner_tag/data/repositories/event/event_repository.dart';
import 'package:schoner_tag/data/repositories/group/group_repository.dart';
import 'package:schoner_tag/modules/authentication/auth_gate.dart';

import 'business/blocs/children/children_bloc.dart';
import 'business/blocs/group/group_bloc.dart';
import 'config/routes.dart';
import 'business/cubits/group_page/group_page_cubit.dart';
import 'firebase_options.dart';
import 'modules/authentication/components/questions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  final authRepository = AuthRepository();
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  const MyApp({super.key, required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NavBarCubit(),
          ),
          BlocProvider(
            create: (context) => EventBloc(eventRepository: EventRepository())
              ..add(LoadEvents()),
          ),
          BlocProvider(
              create: (context) =>
                  GroupBloc(groupRepository: GroupRepository())),
          BlocProvider(
              create: (context) =>
                  GroupPageCubit(groupRepository: GroupRepository())),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthGate(),
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
