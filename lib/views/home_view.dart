import 'package:flutter/material.dart';
import '../widgets/game_custom_paint.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(32),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'I am Jung Hyunmin!',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
            child: GameCustomPaint(),
          ),
        ],
      ),
    );
  }
}
