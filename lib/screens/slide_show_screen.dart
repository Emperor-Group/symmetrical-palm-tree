import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:headers/themes/theme.dart';
import 'package:headers/widgets/slideshow/slideshow.dart';
import 'package:provider/provider.dart';

class SlideShowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Expanded(child: MySlideShow()),
      Expanded(child: MySlideShow()),
    ];

    return Scaffold(
      body: MediaQuery.of(context).size.height > 500
          ? Column(
              children: children,
            )
          : Row(
              children: children,
            ),
    );
  }
}

class MySlideShow extends StatelessWidget {
  const MySlideShow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appThemeChanger = Provider.of<ThemeChanger>(context);
    return SlideShow(
      dotsAbove: false,
      slides: <Widget>[
        SvgPicture.asset('assets/images/android.svg'),
        SvgPicture.asset('assets/images/app.svg'),
        SvgPicture.asset('assets/images/data.svg'),
        SvgPicture.asset('assets/images/insert.svg'),
        SvgPicture.asset('assets/images/post.svg'),
      ],
      selectedColor: appThemeChanger.darkTheme == true
          ? appThemeChanger.currentTheme.accentColor
          : Colors.deepPurple,
      unSelectedColor:
          appThemeChanger.darkTheme == true ? Colors.white : Colors.grey,
      primaryBullet: 14,
      secondaryBullet: 12,
    );
  }
}
