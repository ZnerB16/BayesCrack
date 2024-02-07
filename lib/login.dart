import 'package:flutter/material.dart';
import 'signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(

            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(top: 100)
              ),
              const Text(
                'Welcome!',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(bottom: 20)
              ),
              const Text(
                  'This is a description wenk wenk',
                  style: TextStyle(
                      fontSize: 16
                  )
              ),
              const Padding(
                  padding: EdgeInsets.only(bottom: 80)
              ),
              const SizedBox(
                width: 280,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                      filled: true,
                      fillColor: Colors.black12
                  ),

                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(bottom: 20)
              ),
              const SizedBox(
                width: 280,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.black12
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(bottom: 30)
              ),
              Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all()
                  ),
                  child: TextButton(
                      onPressed: () {
                        /*TO DO*/
                      },
                      child: const Text(
                        'LOG IN',
                        style: TextStyle(color: Colors.black),
                      )
                  )
              ),
              const Padding(
                  padding: EdgeInsets.only(bottom: 10)
              ),
              TextButton(onPressed: () {
                /*TO DO*/
              },
                child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18
                    )
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(bottom: 150)
              ),
              TextButton(onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Signup())
                );
              },
                child: const Text(
                    'Create Account',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        decoration: TextDecoration.underline
                    )
                ),

              ),
            ],
          ),
        )
    );
  }
}