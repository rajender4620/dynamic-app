// // ignore_for_file: lines_longer_than_80_chars

// import 'package:flutter/material.dart';
// import 'package:hni_customers_app/blocs/homepage/view/homepage_view.dart';

// class WelcomePage extends StatelessWidget {
//   const WelcomePage({required this.toggleTheme, super.key});
//   final VoidCallback toggleTheme;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Theme.of(context).primaryColor,
//               Theme.of(context).primaryColorLight,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Logo or Icon
//             const Icon(
//               Icons.dynamic_form,
//               size: 100,
//               color: Colors.white,
//             ),
//             const SizedBox(height: 20),
//             // App Name
//             Text(
//               'Dynamic Forms App',
//               style: Theme.of(context)
//                   .textTheme
//                   .displayLarge
//                   ?.copyWith(color: Colors.white),
//             ),
//             const SizedBox(height: 20),
//             // App Purpose
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 'Create and manage dynamic forms with ease. Switch between light and dark modes for a personalized experience.',
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyLarge
//                     ?.copyWith(color: Colors.white70),
//               ),
//             ),
//             const SizedBox(height: 80),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 60),
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push<void>(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => HomePage(toggleTheme: toggleTheme),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                   backgroundColor: Theme.of(context).primaryColorLight,
//                   minimumSize: const Size(80, 30),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Get Started',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hni_customers_app/blocs/homepage/view/homepage_view.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({required this.toggleTheme, super.key});
  final VoidCallback toggleTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              kIsWeb
                  ? 'Dynamic Forms App'
                  : Platform.isAndroid
                      ? 'Dynamic Forms App'
                      : Platform.isIOS
                          ? 'Dynamic Forms App'
                          : 'Dynamic Forms App',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // App Purpose
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                kIsWeb
                    ? 'Create and manage dynamic forms on the web with ease. Switch between light and dark modes for a personalized experience.'
                    : 'Create and manage dynamic forms with ease on mobile devices. Enjoy light and dark modes for a tailored experience.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 80),

            // Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(toggleTheme: toggleTheme),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Theme.of(context).primaryColorLight,
                  minimumSize: const Size(80, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Get Started',
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
