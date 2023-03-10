import 'package:flutter/material.dart';
import 'package:medizda/constants.dart';
import 'package:medizda/pages/authentication/text_field.dart';

import 'log_in.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Container(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: defaultPadding),
              child: SizedBox(
                width: 400,
                height: 580,
                child: Container(
                    color: primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: defaultPadding * 2),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultPadding),
                          child:
                              Text('Welcome to Amarena!\nSign In to Continue',
                                  style: TextStyle(
                                    color: backgroundColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: defaultPadding,
                              right: defaultPadding,
                              bottom: defaultPadding),
                          child: Row(
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()),
                                    );
                                  },
                                  child: const Text(
                                    'Create an account',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: defaultPadding * 2),
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            child: AuthenticationTextField(
                              label: 'Username',
                              isObscured: false,
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.black),
                            )),
                        const SizedBox(height: defaultPadding * 2),
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            child: AuthenticationTextField(
                              label: 'Password',
                              isObscured: true,
                              prefixIcon: Icon(Icons.lock, color: Colors.black),
                              suffixIcon: Icon(Icons.remove_red_eye),
                            )),
                        const SizedBox(height: defaultPadding * 2),
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            child: AuthenticationTextField(
                              label: 'Confirm Password',
                              isObscured: true,
                              prefixIcon: Icon(Icons.lock, color: Colors.black),
                              suffixIcon: Icon(Icons.remove_red_eye),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LogInPage()),
                                  );
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(height: 2 * defaultPadding),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                backgroundColor),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LogInPage()),
                                        );
                                      },
                                      child: const Text(
                                        'Sign In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            const Spacer(),
          ],
        ));
  }
}
