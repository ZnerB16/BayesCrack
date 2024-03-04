import 'package:flutter/material.dart';
import 'package:mobile_app/create_account.dart';
import 'create_account.dart';

// Username input class
class LoginUser extends StatefulWidget{
  const LoginUser({super.key});
  @override
  State<LoginUser> createState() => _LoginUserState();
}
class _LoginUserState extends State<LoginUser> {
  bool isVisible = false;
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 200)),
            const Center(
                child: Image(
                  image: AssetImage('assets/images/logo_text.png'), // Logo
                  width: 300
                )
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),

            // Username input sized box
            const SizedBox(
                width: 280,
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff284b63), width: 2.0)
                      ),
                      hintText: 'Username',
                      filled: true,
                      fillColor: Colors.black12

                  ),
                )
            ),
            //Hidden error message, change states when username not found
            // *not functional yet*
            Visibility(
                visible: isVisible,
                child: const Padding(
                  padding: EdgeInsets.only(top: 5, right: 45),
                  child: Text(
                    'Username not found! Please try again.',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
            ),
            const Padding(padding: EdgeInsets.only(top: 35)),

            // Next button using container, box decoration, and align
            Padding(
                padding: const EdgeInsets.only(right: 45),
              child:  Align(
                alignment: Alignment.centerRight,
                child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: const Color(0xff284b63),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xff284b63)
                        ),
                        boxShadow:  [BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 1), // changes position of shadow
                        ),
                        ]
                    ),
                    child: TextButton(
                        onPressed: (){
                          Navigator.push(
                            context, MaterialPageRoute(builder: (_) => const LoginPass())
                            );
                          },
                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    )
                ),
              ),
            ),

            const Padding(padding: EdgeInsets.only(top: 50)),

            // Create Account text, box decoration as custom underline
            Container(
              height: 33,
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.2,
                    )
                )
              ),
              child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateAccountFN())
                    );
                  },
                  child: const Text(
                      'Create Account',
                    style: TextStyle(
                        color: Color(0xff414040),
                      fontSize: 14
                    ),
                  )
              ),
            ),

          ],
        )
    );
  }
}

// Password input class
class LoginPass extends StatefulWidget{
  const LoginPass ({super.key});

  @override
  State<LoginPass > createState() => _LoginPassState();
}
class _LoginPassState extends State<LoginPass > {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 200)),
            const Center(
                child: Image(
                    image: AssetImage('assets/images/logo_text.png'),
                    width: 300
                )
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            const SizedBox(
                width: 280,
                height: 55,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff284b63), width: 2.0)
                      ),
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.black12

                  ),
                )
            ),
            Visibility(
              visible: isVisible,
              child: const Padding(
                padding: EdgeInsets.only(top: 5, right: 60),
                child: Text(
                  'Wrong password! Please try again.',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12
                  ),
                ),
              ),
            ),

            const Padding(padding: EdgeInsets.only(top: 35)),
            Padding(
              padding: const EdgeInsets.only(right: 45),
              child:  Align(
                alignment: Alignment.centerRight,
                child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: const Color(0xff284b63),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xff284b63)
                        ),
                        boxShadow:  [BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 1), // changes position of shadow
                        ),
                        ]
                    ),
                    child: TextButton(
                        onPressed: (){
                          // Change LoginUser() for the Main Menu
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginUser()));
                        },
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    )
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            TextButton(
                onPressed: (){/*TO DO*/},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: Color(0xff414040),
                      fontSize: 14
                  ),
                )
            ),
          ],
        )
    );
  }
}