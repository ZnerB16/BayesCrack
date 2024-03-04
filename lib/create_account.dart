import 'package:flutter/material.dart';
import 'package:mobile_app/login.dart';

class CreateAccountFN extends StatefulWidget{
  const CreateAccountFN({super.key});
  @override
  State<CreateAccountFN> createState() => _CreateAccountFN();
}
class _CreateAccountFN extends State<CreateAccountFN> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 120)),
          const Center(
            child: Image(
            image: AssetImage('assets/images/logo_text.png'), // Logo
              width: 200
              )
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          const Center(
            child:Text(
              'Create Account',
              style: TextStyle(
                color: Color(0xff284b63),
                fontSize: 24,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          const SizedBox(
              width: 300,
              child: Text(
                  'Please enter your full name to create your account.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),
                textAlign: TextAlign.center,
              ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          const SizedBox(
              width: 280,
              height: 55,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff284b63), width: 2.0)
                    ),
                    hintText: 'Full Name',
                    filled: true,
                    fillColor: Colors.black12
                ),
              )
          ),
          const Padding(padding: EdgeInsets.only(top: 40)),
            SizedBox(
              width: 500,
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color(0xffd9d9d9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xffd9d9d9)
                            ),
                            boxShadow:  [BoxShadow(
                              color: Colors.black.withOpacity(0.20),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 7), // changes position of shadow
                            ),
                            ]
                        ),
                        child: TextButton(
                            onPressed: (){
                              Navigator.push(
                                 context, MaterialPageRoute(builder: (_) => const LoginUser())
                              );
                            },
                            child: const Text(
                              'CANCEL',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                        )
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Align(
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
                               context, MaterialPageRoute(builder: (_) => const CreateAccountUN())
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
              ],
            ),
            ),
        ],
      ),
    );
  }
}

class CreateAccountUN extends StatefulWidget{
  const CreateAccountUN({super.key});
  @override
  State<CreateAccountUN> createState() => _CreateAccountUN();
}
class _CreateAccountUN extends State<CreateAccountUN> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 120)),
          const Center(
              child: Image(
                  image: AssetImage('assets/images/logo_text.png'), // Logo
                  width: 200
              )
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          const Center(
            child:Text(
              'Create Account',
              style: TextStyle(
                  color: Color(0xff284b63),
                  fontSize: 24,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          const SizedBox(
            width: 320,
            child: Text(
              'Please enter your preferred username. This will be used when you log in to your account.',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
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
          const Padding(padding: EdgeInsets.only(top: 40)),
          SizedBox(
            width: 500,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: const Color(0xffd9d9d9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xffd9d9d9)
                          ),
                          boxShadow:  [BoxShadow(
                            color: Colors.black.withOpacity(0.20),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 7), // changes position of shadow
                          ),
                          ]
                      ),
                      child: TextButton(
                          onPressed: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) => const CreateAccountFN())
                            );
                          },
                          child: const Text(
                            'BACK',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                      )
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Align(
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
                             context, MaterialPageRoute(builder: (_) => const CreateAccountPass())
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreateAccountPass extends StatefulWidget{
  const CreateAccountPass({super.key});
  @override
  State<CreateAccountPass> createState() => _CreateAccountPass();
}
class _CreateAccountPass extends State<CreateAccountPass> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 120)),
          const Center(
              child: Image(
                  image: AssetImage('assets/images/logo_text.png'), // Logo
                  width: 200
              )
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          const Center(
            child:Text(
              'Create Account',
              style: TextStyle(
                  color: Color(0xff284b63),
                  fontSize: 24,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          const SizedBox(
            width: 400,
            child: Text(
              'Please enter your preferred password.',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
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
          const Padding(padding: EdgeInsets.only(top: 20)),
          const SizedBox(
              width: 280,
              height: 55,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff284b63), width: 2.0)
                    ),
                    hintText: 'Confirm Password',
                    filled: true,
                    fillColor: Colors.black12
                ),
              )
          ),
          const Padding(padding: EdgeInsets.only(top: 40)),
          SizedBox(
            width: 500,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: const Color(0xffd9d9d9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xffd9d9d9)
                          ),
                          boxShadow:  [BoxShadow(
                            color: Colors.black.withOpacity(0.20),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 7), // changes position of shadow
                          ),
                          ]
                      ),
                      child: TextButton(
                          onPressed: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) => const CreateAccountUN())
                            );
                          },
                          child: const Text(
                            'BACK',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                      )
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Align(
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
                              // Insert loading screen and successful screen here
                                context, MaterialPageRoute(builder: (_) => const _Success())
                            );
                          },
                          child: const Text(
                            'SUBMIT',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Success extends StatelessWidget{
  const _Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            const Center(
              child: Image(
                image: AssetImage('assets/images/blue_checkmark.png'),
                width: 150,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            const SizedBox(
              width: 200,
              child: Text(
                'Account created successfully.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff414040)
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Align(
              alignment: Alignment.center,
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
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: const Offset(0, 3), // changes position of shadow
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
          ],
        )
    );
  }
}



