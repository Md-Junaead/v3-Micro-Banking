import 'package:flutter/material.dart';

class ComonAppbar extends StatelessWidget {
  const ComonAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + MediaQuery.of(context).size.height * 0.03),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 30, // Customize icon color
          ),
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height *
                    0.03), // Moves text 5% down
            child: const Text("Balance"),
          ),
          backgroundColor: Color(0xFF06426D),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),
        ),
      ),
    );
  }
}
