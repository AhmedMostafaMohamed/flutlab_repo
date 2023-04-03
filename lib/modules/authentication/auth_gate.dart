import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:schoner_tag/shared/components/my_textfield.dart';

import '../home/home_screen.dart';
import 'components/info.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs: const [
              EmailProviderConfiguration(),
              // GoogleProviderConfiguration(
              //     clientId:
              //         '383923535430-17dqa0r1eemakpsl48hqtg4063rnm0tb.apps.googleusercontent.com'),
            ],
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to SchonerTag, please sign in!')
                    : const Text('Welcome to SchonerTag, please sign up!'),
              );
            },
            // footerBuilder: (context, action) {
            //   return const Padding(
            //     padding: EdgeInsets.only(top: 16),
            //     child: Text(
            //       'By signing in, you agree to our terms and conditions.',
            //       style: TextStyle(color: Colors.grey),
            //     ),
            //   );
            // },
          );
        }

        return FirebaseAuth.instance.currentUser!.displayName == null
            ? const InfoScreen()
            : const HomeScreen();
      },
    );
  }
}
