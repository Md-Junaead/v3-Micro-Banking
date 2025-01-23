import 'dart:async';
import 'package:flutter/material.dart';

class UserAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String profileName;
  final String profileImageUrl;
  final Future<String> Function() fetchUserId; // API call to fetch user ID

  const UserAppBar({
    super.key,
    required this.profileName,
    required this.profileImageUrl,
    required this.fetchUserId,
  });

  @override
  _UserAppBarState createState() => _UserAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _UserAppBarState extends State<UserAppBar> {
  String userId = ''; // Variable to hold the fetched User ID

  // Function to fetch User ID from API
  void fetchUserId() async {
    String id = await widget.fetchUserId(); // Fetch user ID from API
    setState(() {
      userId = id; // Update state with fetched user ID
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserId(); // Fetch user ID when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.01),
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF06426D), // AppBar background color
        elevation: 0, // Remove AppBar shadow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Profile Picture Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: CircleAvatar(
                radius: 28, // Profile image size
                backgroundImage:
                    NetworkImage(widget.profileImageUrl), // Load from API
              ),
            ),

            // Profile Name & User ID Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.profileName, // Display profile name
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 5), // Space between name and user ID
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFdfe1e6), // Background color
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: Text(
                    userId.isNotEmpty
                        ? "User ID: $userId"
                        : "Fetching...", // Display User ID
                    style: const TextStyle(color: Colors.black, fontSize: 16),
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

// Usage:
// UserAppBar(
//   profileName: profileName,
//   profileImageUrl: profileImageUrl,
//   fetchUserId: fetchUserId, // API method to fetch user ID
// )
