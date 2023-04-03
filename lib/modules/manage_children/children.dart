import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../shared/components/my_button.dart';
import 'children_body.dart';

class ChildrenScreen extends StatelessWidget {
  const ChildrenScreen({super.key});
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ChildrenScreen());
  }

  @override
  Widget build(BuildContext context) {
    return MyButton(
        onPressed: () {
          Navigator.of(context).push<void>(ChildrenBody.route());
        },
        buttonText: 'Manage children');
  }
}
