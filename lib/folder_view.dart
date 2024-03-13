import 'package:flutter/material.dart';
import 'gallery.dart';


class FolderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ImageGrid(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}


class ImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return GridView.builder(
      itemCount: 9, 
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // roooowsss
        crossAxisSpacing: 8.0, 
        mainAxisSpacing: 8.0, 
      ),
      itemBuilder: (context, index) { 
        return Image.asset(
          'assets/images/brenz.png', 
          fit: BoxFit.cover,
        );
      },
    );
  }
}