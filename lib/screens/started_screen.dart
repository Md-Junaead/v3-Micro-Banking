import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class StartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF06426D), // Background color
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image Slider
          Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.1),
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.6,
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 1.0,
              ),
              items: [
                'assets/images/image_one.jpeg',
                'assets/images/image_one.jpeg',
                'assets/images/image_one.jpeg',
              ].map((imagePath) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.05),
                  child: Image.asset(
                    imagePath,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),
          ),
          // Buttons Section
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(context, 'Login', () {
                  Navigator.pushNamed(context, '/login_screen');
                }),
                _buildButton(context, 'Get Started', () {
                  // Add desired action for Get Started
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.35,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Averia Libre',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
