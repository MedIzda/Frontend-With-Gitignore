import 'package:flutter/material.dart';
import 'package:medizda/pages/authentication/log_in.dart';

class ExpiredSignUpPage extends StatelessWidget {
  const ExpiredSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            alignment: Alignment.center,
            child: Container(
                color: Colors.white,
                width: 400,
                height: 500,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    //siema
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Text('S I G N   U P   W I N D O W',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          )),
                    ),
                    const SizedBox(height: 64),
                    //username
                    const Padding(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'username',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    //password
                    const Padding(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'password',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    //confirm password
                    const Padding(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'confirm password',
                        ),
                      ),
                    ),

                    //log in
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogInPage()),
                          );
                        },
                        child: const Text(
                          '(already have an account? log in instead)',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )),
                    const SizedBox(height: 32),
                    //sign in
                    SizedBox(
                      width: 128,
                      height: 64,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogInPage()),
                            );
                          },
                          child: const Text(
                            'S I G N   U P',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )),
                    ),
                  ],
                ))));
  }
}
