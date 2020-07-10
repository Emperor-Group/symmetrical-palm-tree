import 'package:flutter/material.dart';
import 'package:headers/themes/theme.dart';
import 'package:headers/widgets/headers/peak_header.dart';
import 'package:headers/widgets/headers/wave_header.dart';
import 'package:provider/provider.dart';

class HeadersScreen extends StatelessWidget {
  const HeadersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      body: WaveHeader(
          color: appTheme.darkTheme
              ? appTheme.currentTheme.accentColor
              : appTheme.currentTheme.primaryColor),
    );
  }
}
