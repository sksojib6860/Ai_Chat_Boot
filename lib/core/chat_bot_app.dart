import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentations/providers/chat_provider.dart';
import '../presentations/screens/home/home_page.dart';
import '../presentations/screens/splash_screen/splash_screen.dart';

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: MaterialApp(
        title: 'Chat AI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        ),
        initialRoute: '/splash',
        routes: {
          HomePage.name: (context) => const HomePage(),
          SplashScreen.name: (context) => const SplashScreen(),
        },
      ),
    );
  }
}
