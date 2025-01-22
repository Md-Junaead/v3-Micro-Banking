import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:v1_micro_finance/configs/routes/routes_name.dart';

class StartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF06426D), // Background color
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Image Slider
          Container(
            margin: EdgeInsets.only(
                top:
                    MediaQuery.of(context).size.height * 0.10, // 10% margin top
                bottom: MediaQuery.of(context).size.height *
                    0.10), // 10% margin bottom
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height *
                    0.6, // Slider height 60% of screen
                enlargeCenterPage:
                    true, // Enlarges center item for better visibility
                autoPlay: true, // Enables auto sliding
                viewportFraction: 1.0, // Ensures full width coverage
              ),
              items: [
                'assets/images/image_one.jpeg',
                'assets/images/image_two.jpeg',
                'assets/images/image_three.jpeg',
              ].map((imagePath) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width *
                          0.05), // Rounded corners for images
                  child: Image.asset(
                    imagePath,
                    width:
                        MediaQuery.of(context).size.width, // Full width images
                    fit:
                        BoxFit.cover, // Ensures images cover container properly
                  ),
                );
              }).toList(),
            ),
          ),
          // Buttons Section
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width *
                    0.12), // Horizontal padding for buttons
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Spacing between buttons
              children: [
                _buildButton(context, 'Login', () {
                  Navigator.pushNamed(context,
                      RoutesName.signInScreen); // Navigates to login screen
                }),
                _buildButton(context, 'Get Started', () {
                  Navigator.pushNamed(context, RoutesName.signupScreen);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to create buttons
  Widget _buildButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      height: MediaQuery.of(context).size.height *
          0.05, // Button height 5% of screen
      child: ElevatedButton(
        onPressed: onPressed, // Click event for button
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Button background color
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Rounded corners for buttons
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black, // Text color
            fontFamily: 'Averia Libre', // Font family for button text
            fontSize: 18, // Font size
            fontWeight: FontWeight.bold, // Bold text
          ),
        ),
      ),
    );
  }
}
