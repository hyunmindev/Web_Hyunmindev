import 'package:flutter/material.dart';
import 'package:hyunmindev/utils/showEmaildialog.dart';
import 'package:provider/provider.dart';
import '../providers/main_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonView extends StatelessWidget {
  final Widget body;

  const CommonView({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hyunmindev'),
        actions: [
          IconButton(
            iconSize: 32,
            onPressed: () {
              _launchURL('https://blog.hyunmin.dev');
            },
            tooltip: 'Tistory',
            icon: Image.asset('assets/tistory-logo-white.png'),
          ),
          SizedBox(
            width: 12,
          ),
          IconButton(
            iconSize: 32,
            onPressed: () {
              _launchURL('https://github.com/hyunmindev');
            },
            tooltip: 'GitHub',
            icon: Image.asset('assets/github-logo-white.png'),
          ),
          SizedBox(
            width: 24,
          ),
          ThemeSwitch(),
          SizedBox(
            width: 24,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEmailDialog(context, 'jung@hyunmin.dev');
        },
      ),
      body: body,
    );
  }
}

class ThemeSwitch extends StatefulWidget {
  _ThemeSwitchState createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: _isDarkTheme,
        onChanged: (value) {
          setState(() {
            _isDarkTheme = value;
            context.read<MainTheme>().setIsDarkTheme(value);
          });
        });
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
