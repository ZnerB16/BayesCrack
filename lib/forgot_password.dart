import 'package:flutter/material.dart';
import 'login.dart';

class ForgotPasswordMN extends StatefulWidget{
  const ForgotPasswordMN({super.key});

  @override
  State<ForgotPasswordMN> createState() => _ForgotPasswordMN();
}
class _ForgotPasswordMN extends State<ForgotPasswordMN>{
  bool _isVisible = false;

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
              'Account Recovery',
              style: TextStyle(
                  color: Color(0xff284b63),
                  fontSize: 24,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          const SizedBox(
            width: 300,
            child: Text(
              'Please enter your mobile number to get your verification code.',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          const SizedBox(
              width: 280,
              height: 55,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff284b63), width: 2.0)
                    ),
                    hintText: 'Mobile Number',
                    filled: true,
                    fillColor: Colors.black12
                ),
              )
          ),
          // Hidden error message, change states when number is not found
          // *not functional yet*
          Visibility(
              visible: _isVisible,
              child: const Padding(
                padding: EdgeInsets.only(top: 5 , right: 60),
                child: Text(
                  'Number not found! Please try again.',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12
                  ),

                ),
          ),
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
                                context, MaterialPageRoute(builder: (_) => const ForgotPasswordVC())
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

class ForgotPasswordVC extends StatefulWidget{
  const ForgotPasswordVC({super.key});

  @override
  State<ForgotPasswordVC> createState() => _ForgotPasswordVC();
}
class _ForgotPasswordVC extends State<ForgotPasswordVC>{
  bool _isVisible = false;

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
              'Account Recovery',
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
              'Please type the verification code sent to your mobile number.',
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
                    hintText: 'Verification Code',
                    filled: true,
                    fillColor: Colors.black12
                ),
              )
          ),
          // Hidden error message, change states when verification code is incorrect
          // *not functional yet*
          Visibility(
            visible: _isVisible,
            child: const Padding(
              padding: EdgeInsets.only(top: 5 , right: 60),
              child: Text(
                'Wrong verification code! Please try again.',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12
                ),
              ),
            ),
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
                                context, MaterialPageRoute(builder: (_) => const ForgotPasswordMN())
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
                                context, MaterialPageRoute(builder: (_) => const ForgotPasswordCP())
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

class ForgotPasswordCP extends StatefulWidget{
  const ForgotPasswordCP({super.key});
  @override
  State<ForgotPasswordCP> createState() => _ForgotPasswordCP();
}
class _ForgotPasswordCP extends State<ForgotPasswordCP> {
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
              'Change Password',
              style: TextStyle(
                  color: Color(0xff284b63),
                  fontSize: 24,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          const Image(
              image: AssetImage('assets/images/profile_placeholder.png'),
            width: 100,
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const Text(
            'John Doe Dela Cruz',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600
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
          Padding(
            padding: EdgeInsets.only(right: 55),
            child: Align(
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
                              // Insert successful screen here
                                context, MaterialPageRoute(builder: (_) => const _Success())
                            );
                          },
                          child: const Text(
                            'CONFIRM',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      )
                  ),
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
              'Password changed successfully.',
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


