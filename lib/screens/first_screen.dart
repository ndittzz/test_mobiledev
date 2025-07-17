import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/palindrome_provider.dart';
import '../screens/second_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PalindromeProvider>(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          // Main content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                CircleAvatar(
                  radius: 58,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/ic_photo.png'),
                ),
                const SizedBox(height: 40),

                // Name Input
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Name',
                    hintStyle: const TextStyle(color: Color(0x6867775C)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: provider.setName,
                ),
                const SizedBox(height: 16),

                // Palindrome Input
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Palindrome',
                    hintStyle: const TextStyle(color: Color(0x6867775C)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  onChanged: provider.setSentence,
                ),
                const SizedBox(height: 48),

                // Check Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2B637B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (provider.sentence.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a sentence to check'),
                          ),
                        );
                        return;
                      }

                      final isPal = provider.isPalindrome(provider.sentence);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Palindrome Check'),
                          content: Text(
                            isPal ? 'isPalindrome' : 'not palindrome',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'CHECK',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2B637B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (provider.name.trim().isEmpty ||
                          provider.sentence.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please complete all fields'),
                          ),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SecondScreen(),
                        ),
                      );
                    },

                    child: const Text(
                      'NEXT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
