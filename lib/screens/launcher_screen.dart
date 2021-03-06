import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:headers/routes/routes.dart';
import 'package:headers/themes/theme.dart';
import 'package:provider/provider.dart';

class LauncherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Desings'),
        backgroundColor: appTheme.currentTheme.accentColor,
      ),
      drawer: _MainMenuDrawer(),
      body: OptionsList(),
    );
  }
}

class OptionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        leading: FaIcon(
          pageRoutes[index].icon,
          color: appTheme.accentColor,
        ),
        title: Text(pageRoutes[index].title),
        trailing: Icon(
          Icons.chevron_right,
          color: appTheme.accentColor,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pageRoutes[index].screen,
            ),
          );
        },
      ),
      separatorBuilder: (context, index) => Divider(
        color: appTheme.primaryColorLight,
      ),
      itemCount: pageRoutes.length,
    );
  }
}

class _MainMenuDrawer extends StatelessWidget {
  const _MainMenuDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);

    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: appTheme.currentTheme.accentColor,
                  child: Text(
                    'AR',
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: OptionsList(),
            ),
            SafeArea(
              bottom: true,
              right: false,
              left: false,
              top: false,
              child: ListTile(
                leading: Icon(
                  Icons.lightbulb_outline,
                ),
                title: Text('Dark Mode'),
                trailing: Switch.adaptive(
                  value: appTheme.darkTheme,
                  onChanged: (value) {
                    appTheme.darkTheme = value;
                  },
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.add_to_home_screen,
              ),
              title: Text('Custom Theme'),
              trailing: Switch.adaptive(
                value: appTheme.customTheme,
                onChanged: (value) {
                  appTheme.customTheme = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
