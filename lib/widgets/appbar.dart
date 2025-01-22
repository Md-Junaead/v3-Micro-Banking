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

  // Function to simulate fetching balance from API
  void onCheckBalance() async {
    setState(() {
      isBalanceSliding = true; // Start the sliding effect
    });

    // Simulate fetching balance from the server (using the provided API method)
    String balance = await widget.fetchBalance();

    // Update balance and make it visible
    setState(() {
      balanceAmount = balance;
      isBalanceVisible = true;
    });

    // After 15 seconds, hide the balance and stop the sliding effect
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.05), // 5% padding at the bottom
      child: AppBar(
        backgroundColor: const Color(0xFF06426D), // AppBar background color
        elevation: 0,
        toolbarHeight: 100, // Height of the AppBar (in pixels)
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align elements to the start
          children: [
            // Section 1: Drawer Icon (Left-most Section)
            IconButton(
              icon: const Icon(Icons.menu, size: 45, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer on tap
              },
            ),

            // Section 2: Profile Picture (Middle Section)
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 15), // Horizontal margin
              child: CircleAvatar(
                radius: 28, // Size of the profile image
                backgroundImage:
                    NetworkImage(widget.profileImageUrl), // Load from API
              ),
            ),

            // Section 3: Profile Name & Check Balance Button (Right-most Section)
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Align start of text
              children: [
                Text(
                  widget.profileName, // Display profile name
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(
                    height: 5), // Space between name and balance button
                GestureDetector(
                  onTap: onCheckBalance, // Trigger balance check on tap
                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 300), // Smooth transition
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey, // Button background color
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    child: AnimatedCrossFade(
                      firstChild: Text(
                        "Check Balance", // Default text when balance is not visible
                        style: const TextStyle(color: Colors.white),
                      ),
                      secondChild: Text(
                        isBalanceVisible
                            ? balanceAmount
                            : "", // Show balance if visible
                        style: const TextStyle(color: Colors.white),
                      ),
                      crossFadeState: isBalanceVisible
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst, // Cross-fade effect
                      duration: const Duration(milliseconds: 300),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
