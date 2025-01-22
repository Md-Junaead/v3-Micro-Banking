import 'package:flutter/material.dart';
import 'package:v1_micro_finance/screens/auth/signin_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/check_balance_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/packages_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/referrals_screen.dart';
import 'package:v1_micro_finance/screens/dashboard/withdraw_screen.dart';
import 'package:v1_micro_finance/test/test.dart';
import 'package:v1_micro_finance/widgets/appbar.dart';

void main() {
  runApp(const MicroFinance());
}

class MicroFinance extends StatelessWidget {
  const MicroFinance({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(), // Set HomeScreen as the main screen
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String profileName = "User Name"; // Placeholder profile name from API
  String profileImageUrl =
      "https://via.placeholder.com/150"; // Placeholder profile image
  bool isBalanceVisible = false;
  String balanceAmount = "\$1000"; // Placeholder balance from API

  void toggleBalance() {
    setState(() {
      isBalanceVisible = !isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> buttons = [
      {"icon": Icons.attach_money, "text": "Deposit", "screen": TestScreen()},
      {
        "icon": Icons.account_balance,
        "text": "Check Balance",
        "screen": CheckBalanceScreen()
      },
      {"icon": Icons.money_off, "text": "Withdraw", "screen": WithdrawScreen()},
      {"icon": Icons.people, "text": "Referrals", "screen": ReferralsScreen()},
      {"icon": Icons.speed, "text": "Quick Loan", "screen": SignInScreen()},
      {
        "icon": Icons.card_giftcard,
        "text": "Packages",
        "screen": PackagesScreen()
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(
        profileName: profileName,
        profileImageUrl: profileImageUrl,
        onCheckBalance: toggleBalance,
        isBalanceVisible: isBalanceVisible,
        balanceAmount: balanceAmount,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height *
                0.05, // 5% top & bottom padding
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                final button = buttons[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => button["screen"],
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF06426D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          button["icon"],
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          button["text"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
