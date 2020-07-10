import 'package:flutter/material.dart';
import 'package:headers/models/layout_model.dart';
import 'package:headers/screens/launcher_screen.dart';
import 'package:headers/screens/launcher_tablet_screen.dart';
import 'package:headers/screens/sliver_list_screen.dart';
import 'package:headers/themes/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeChanger(2),
        ),
        ChangeNotifierProvider(
          create: (context) => LayoutModel(),
        )
      ],
      child: Builder(builder: (ctx) {
        final appTheme = Provider.of<ThemeChanger>(ctx).currentTheme;
        return MaterialApp(
          theme: appTheme,
          title: 'Designs App',
          home: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              final deviceSize = MediaQuery.of(context).size;
              if (deviceSize.width > 500) {
                return LauncherTabletScreen();
              }
              return LauncherScreen();
            },
          ),
        );
      }),
    );
  }
}
