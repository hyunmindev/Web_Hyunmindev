import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/common_view.dart';
import 'providers/theme.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyTheme(),
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
      theme: context.watch<MyTheme>().theme,
      home: CommonView(),
    );
  }
}
