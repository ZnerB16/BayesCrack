import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'database/database_service.dart';
import 'main_menu.dart';
import 'database/crack_db.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Image.asset(
              'assets/images/logo_text.png', // Replace with the path to your image
              width: 300.0, // Adjust the width as needed
              height: 300.0, // Adjust the height as needed
            ),
            
            // SizedBox for spacing
            const SizedBox(height: 20.0),

            // Button Widget
            ElevatedButton(
              onPressed: () async {
                final database = await DatabaseService().database;
                var crackDB = CrackDB();
                crackDB.createTable(database);
                await Permission.location.request();

                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const MainMenu()),
                );
              },
              
              style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff284b63),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

              child: const Text('START',
                style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}


