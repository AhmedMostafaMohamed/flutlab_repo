import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:schoner_tag/modules/home/home_screen.dart';
import 'package:schoner_tag/shared/components/my_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Questions());
  }

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  var pageNum = 0;
  var isLoading = false;
  final controller = PageController(initialPage: 0);
  List<String> questions = [
    'Do you allow taking pictures for you and your children?',
    'Do you agree to share yours and your children\'s pictures on the internet?',
    'Do you agree to share your children\'s pictures over the whatsapp group?',
    'what\'s the ideal method to reach you?',
  ];
  List<String> answers = ['Yes', 'Yes', 'Yes', 'Whatsapp'];
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                controller.previousPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut);
              },
              icon: Icon(Icons.arrow_back_ios_new))
        ]),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    pageNum = value;
                  });
                },
                children: [
                  question(
                      number: 0,
                      question: questions[0],
                      questionAnswers: ['Yes', 'No', 'Only for my children'])!,
                  question(
                      number: 1,
                      question: questions[1],
                      questionAnswers: ['Yes', 'No', 'Only for my children'])!,
                  question(
                      number: 2,
                      question: questions[2],
                      questionAnswers: ['Yes', 'No', 'Only for my children'])!,
                  question(
                      number: 3,
                      question: questions[3],
                      questionAnswers: ['Whatsapp', 'phone', 'email'])!,
                ],
              ),
        floatingActionButton: pageNum != 3
            ? MyButton(
                buttonText: 'Next',
                onPressed: () async {
                  controller.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut);
                })
            : MyButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    var i = 0;
                    for (var answer in answers) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({questions[i]: answer});
                      i++;
                    }
                  } catch (e) {
                    print(e);
                  }

                  Navigator.of(context).pushReplacement(HomeScreen.route());
                },
                buttonText: 'Submit'));
  }

  Widget? question({
    int? number,
    String? question,
    List<String>? questionAnswers,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          ToggleSwitch(
            isVertical: true,
            minWidth: 200,
            initialLabelIndex: 0,
            totalSwitches: questionAnswers!.length,
            fontSize: 20,
            labels: questionAnswers,
            onToggle: (index) {
              answers[number!] = questionAnswers[index!];
            },
          ),
        ],
      ),
    );
  }
}
