import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoner_tag/modules/manage_children/add_child.dart';
import 'package:schoner_tag/shared/components/my_button.dart';

import '../../business/blocs/children/children_bloc.dart';
import '../../data/models/child.dart';
import '../../data/repositories/children/children_repository.dart';
import '../../shared/components/data_table.dart';

class ChildrenBody extends StatelessWidget {
  const ChildrenBody({super.key});
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ChildrenBody());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChildrenBloc(childrenRepository: ChildrenRepository())
            ..add(LoadChildren(FirebaseAuth.instance.currentUser!.uid)),
      child: Scaffold(
        appBar: AppBar(title: const Text('children'), actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push<void>(AddChild.route());
              },
              icon: Icon(Icons.add))
        ]),
        body: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              BlocBuilder<ChildrenBloc, ChildrenState>(
                builder: (context, state) {
                  if (state is ChildrenLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ChildrenLoaded) {
                    final DataTableSource data =
                        ChildDataTable(data: state.children);
                    return PaginatedDataTable(
                      source: data,
                      columns: const [
                        DataColumn(label: Text('name')),
                        DataColumn(label: Text('gender')),
                        DataColumn(label: Text('dob')),
                      ],

                      // header: const Center(child: Text('Children')),
                    );
                  }
                  return Container();
                },
              ),
              // MyButton(
              //     onPressed: () {
              //       Navigator.of(context).push<void>(AddChild.route());
              //     },
              //     buttonText: 'Add a child'),
            ]),
          ),
        ),
      ),
    );
  }
}
