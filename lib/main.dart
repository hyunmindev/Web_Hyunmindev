import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/main_theme.dart';
import 'views/common_view.dart';
import 'views/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainTheme(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hyunmindev',
      theme: context.watch<MainTheme>().theme,
      home: CommonView(
        body: HomeView(),
      ),
    );
  }
}
