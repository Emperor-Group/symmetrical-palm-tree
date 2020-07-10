import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:headers/models/slider_model.dart';
import 'package:provider/provider.dart';

class SlideShowScreen extends StatelessWidget {
  const SlideShowScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => new SliderModel(),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: _Slides(),
              ),
              _Dots(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _SingleDot(0),
          _SingleDot(1),
          _SingleDot(2),
        ],
      ),
    );
  }
}

class _SingleDot extends StatelessWidget {
  final int index;

  _SingleDot(this.index);

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      curve: Curves.easeOut,
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
            ? Colors.pink
            : Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(
      () {
        print('Pag actual : ${pageViewController.page}');
        Provider.of<SliderModel>(context, listen: false).currentPage =
            pageViewController.page;
      },
    );
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: <Widget>[
          _SingleSlide('assets/images/android.svg'),
          _SingleSlide('assets/images/app.svg'),
          _SingleSlide('assets/images/data.svg'),
        ],
      ),
    );
  }
}

class _SingleSlide extends StatelessWidget {
  final String svg;

  _SingleSlide(this.svg);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(50),
      child: SvgPicture.asset(svg),
    );
  }
}
