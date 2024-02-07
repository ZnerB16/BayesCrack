import 'package:flutter/material.dart';
import 'package:mobile_app/login.dart';

class Signup extends StatelessWidget{
  const Signup({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.only(bottom: 100)
            ),
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 30
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 50)
            ),
            const SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Full Name',
                    filled: true,
                    fillColor: Colors.black12
                ),

              ),
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 20)
            ),
            const SizedBox(
              width: 300,
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
              width: 300,
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
            Row(
              children: [
                const Padding(
                    padding: EdgeInsets.only(left: 45)
                ),
                Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all()
                    ),
                    child: TextButton(
                        onPressed: (){/*TO DO*/},
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.black),
                        )
                    )
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 100)
                ),
                Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all()
                    ),
                    child: TextButton(
                        onPressed: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => const LoginPage())
                          );
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(color: Colors.black),
                        )
                    )
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}