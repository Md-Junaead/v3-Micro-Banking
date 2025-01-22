// Custom AppBar Widget
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String profileName;
  final String profileImageUrl;
  final VoidCallback onCheckBalance;
  final bool isBalanceVisible;
  final String balanceAmount;

  const CustomAppBar({
    super.key,
    required this.profileName,
    required this.profileImageUrl,
    required this.onCheckBalance,
    required this.isBalanceVisible,
    required this.balanceAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.15), // 15% padding at the bottom
      child: AppBar(
        backgroundColor: const Color(0xFF06426D), // Background color
        elevation: 0,
        toolbarHeight: 100, // Set the height of the AppBar (in pixels)
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align start
          children: [
            // Section 1: Drawer Icon (Left-most Section)
            IconButton(
              icon: const Icon(Icons.menu, size: 45, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            ),

            // Section 2: Profile Picture (Middle Section)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15), // 5% margin
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(profileImageUrl), // Load from API
              ),
            ),

            // Section 3: Profile Name & Check Balance Button (Right-most Section)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align Start
              children: [
                Text(
                  profileName,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: onCheckBalance,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isBalanceVisible ? balanceAmount : "Check Balance",
                      style: const TextStyle(color: Colors.white),
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
