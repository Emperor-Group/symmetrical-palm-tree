import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final bool dotsAbove;
  final Color selectedColor;
  final Color unSelectedColor;
  final double primaryBullet;
  final double secondaryBullet;

  SlideShow({
    @required this.slides,
    this.dotsAbove = false,
    this.selectedColor = Colors.pink,
    this.unSelectedColor = Colors.grey,
    this.primaryBullet = 12,
    this.secondaryBullet = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SliderModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              Provider.of<_SliderModel>(context, listen: false).selectedColor =
                  this.selectedColor;
              Provider.of<_SliderModel>(context, listen: false)
                  .unSelectedColor = this.unSelectedColor;
              Provider.of<_SliderModel>(context, listen: false).primaryBullet =
                  this.primaryBullet;
              Provider.of<_SliderModel>(context, listen: false)
                  .secondaryBullet = this.secondaryBullet;

              return Column(
                children: <Widget>[
                  if (this.dotsAbove)
                    _Dots(
                      this.slides.length,
                    ),
                  Expanded(
                    child: _Slides(this.slides),
                  ),
                  if (!this.dotsAbove)
                    _Dots(
                      this.slides.length,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int numberOfSlides;

  _Dots(
    this.numberOfSlides,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          numberOfSlides,
          (index) => _SingleDot(index),
        ),
      ),
    );
  }
}

class _SingleDot extends StatelessWidget {
  final int index;

  _SingleDot(this.index);

  @override
  Widget build(BuildContext context) {
    final sliderModel = Provider.of<_SliderModel>(context);
    final pageViewIndex = sliderModel.currentPage;
    final selectedColor = sliderModel.selectedColor;
    final unSelectedColor = sliderModel.unSelectedColor;
    final primaryBullet = sliderModel.primaryBullet;
    final secondaryBullet = sliderModel.secondaryBullet;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      curve: Curves.easeInOut,
      width: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
          ? primaryBullet
          : secondaryBullet,
      height: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
          ? primaryBullet
          : secondaryBullet,
      decoration: BoxDecoration(
        color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
            ? selectedColor
            : unSelectedColor,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  _Slides(this.slides);

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
        Provider.of<_SliderModel>(context, listen: false).currentPage =
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
          ...widget.slides.map((e) => _SingleSlide(e)).toList(),
        ],
      ),
    );
  }
}

class _SingleSlide extends StatelessWidget {
  final Widget slide;

  _SingleSlide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(50),
      child: slide,
    );
  }
}

class _SliderModel with ChangeNotifier {
  double _currentPage = 0;
  Color _selectedColor = Colors.blue;
  Color _unSelectedColor = Colors.blue;
  double _primaryBullet = 12;
  double _secondaryBullet = 12;

  double get currentPage => this._currentPage;

  set currentPage(double currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  Color get selectedColor => this._selectedColor;

  set selectedColor(Color newColor) {
    _selectedColor = newColor;
  }

  Color get unSelectedColor => this._unSelectedColor;

  set unSelectedColor(Color newColor) {
    _unSelectedColor = newColor;
  }

  double get primaryBullet => this._primaryBullet;

  set primaryBullet(double size) {
    _primaryBullet = size;
  }

  double get secondaryBullet => this._secondaryBullet;

  set secondaryBullet(double size) {
    _secondaryBullet = size;
  }
}
