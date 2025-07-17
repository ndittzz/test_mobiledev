import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/palindrome_provider.dart';
import '../providers/user_provider.dart';
import 'third_screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palindromeProvider = Provider.of<PalindromeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Second Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.blue),
          onPressed: () {
            userProvider.clearSelectedUser();
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey, height: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome', style: TextStyle(fontSize: 12)),
            Text(
              palindromeProvider.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  Center(
                    // Tambahkan ini
                    child: Text(
                      userProvider.selectedUserName ?? 'Selected User Name',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF32627A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThirdScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Choose a User',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
