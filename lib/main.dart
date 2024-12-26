import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vugars_coffeeshop/application/core/dependency_resolver.dart';
import 'package:vugars_coffeeshop/application/home-page/api-services/abstractions/icoffee_api_service.dart';
import 'package:vugars_coffeeshop/application/home-page/view-model/home_page_view_model.dart';
import 'package:vugars_coffeeshop/application/home-page/views/home_page.dart';
import 'package:vugars_coffeeshop/application/on-boarding/views/onboarding_page.dart';
import 'package:vugars_coffeeshop/application/orders-page/views/orders_page.dart';
import 'package:vugars_coffeeshop/application/successfully-registered/views/successfully_registered_page.dart';

void main() async {
  resolve();
  WidgetsFlutterBinding.ensureInitialized();
  bool isFirstLaunch = await checkFirstLaunch();
  
  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

Future<bool> checkFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  bool? isFirstLaunch = prefs.getBool('isFirstLaunch');
  
  if (isFirstLaunch == null || isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
    return true;
  }
  
  return false;
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isFirstLaunch ? OnboardingPage() : HomePage(),
    );
  }
}
