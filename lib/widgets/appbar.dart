import 'dart:async';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String profileName;
  final String profileImageUrl;
  final Future<String> Function() fetchBalance; // API call to fetch balance

  const CustomAppBar({
    super.key,
    required this.profileName,
    required this.profileImageUrl,
    required this.fetchBalance,
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isBalanceVisible = false; // To control visibility of the balance
  String balanceAmount = ''; // To hold the fetched balance
  bool isBalanceSliding =
      false; // To control the sliding effect for balance display
  late Timer _timer; // Timer to hide balance after some time

  // Function to fetch balance from API
  void onCheckBalance() async {
    setState(() {
      isBalanceSliding = true; // Start the sliding effect
    });

    // Fetch balance from API
    String balance = await widget.fetchBalance();

    // Update balance and make it visible
    setState(() {
      balanceAmount = balance;
      isBalanceVisible = true;
    });

    // Hide balance after 8 seconds
    _timer = Timer(const Duration(seconds: 8), () {
      setState(() {
        isBalanceVisible = false;
        isBalanceSliding = false; // Stop sliding effect
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return Padding(
      padding: const EdgeInsets.only(bottom: 0.01), // Padding at the bottom
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 40),
        backgroundColor: const Color(0xFF06426D), // AppBar background color
        elevation: 0, // Remove shadow
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Responsive alignment
          children: [
            // Profile Picture Section
            CircleAvatar(
              radius: screenWidth * 0.07, // Responsive image size
              backgroundImage:
                  NetworkImage(widget.profileImageUrl), // Load from API
            ),

            const SizedBox(width: 35), // Space between avatar and text

            // Profile Name & Balance Button Section
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to start
                mainAxisSize: MainAxisSize.min, // Minimize column height
                children: [
                  Text(
                    widget.profileName, // Display profile name
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                  ),
                  const SizedBox(
                      height: 5), // Space between name and balance button
                  GestureDetector(
                    onTap: onCheckBalance, // Trigger balance check
                    child: AnimatedContainer(
                      duration: const Duration(
                          milliseconds: 100), // Smooth transition
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03, // Responsive padding
                        vertical: screenWidth * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFFdfe1e6), // Button background color
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      child: AnimatedCrossFade(
                        firstChild: const Text(
                          "Balance", // Default text when balance is not visible
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        secondChild: Text(
                          isBalanceVisible
                              ? balanceAmount
                              : "", // Show balance if visible
                          style: const TextStyle(color: Colors.black),
                        ),
                        crossFadeState: isBalanceVisible
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst, // Cross-fade effect
                        duration: const Duration(milliseconds: 100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
