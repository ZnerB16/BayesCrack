import 'package:flutter/material.dart';
import 'permission_request.dart';
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
              width: 200.0, // Adjust the width as needed
              height: 200.0, // Adjust the height as needed
            ),
            
            // SizedBox for spacing
            SizedBox(height: 20.0),

            // Button Widget
            ElevatedButton(
              onPressed: () async {
                final database = await DatabaseService().database;
                var crackDB = CrackDB();
                crackDB.createTable(database);
                const Permissions().requestLocationPermission();
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const MainMenu()),
                );
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}


