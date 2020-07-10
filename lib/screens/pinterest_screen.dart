import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:headers/themes/theme.dart';
import 'package:headers/widgets/pinterest/pinterest_menu.dart';
import 'package:provider/provider.dart';

class PinteresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (ctx) => _MenuModel(),
        child: Stack(
          children: <Widget>[
            PinterestGrid(
              color: Colors.lightBlue,
            ),
            _PinterestMenuAllocated(),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuAllocated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final show = Provider.of<_MenuModel>(context).show;
    final theme = Provider.of<ThemeChanger>(context);

    return Positioned(
      left: MediaQuery.of(context).size.width * 0.15,
      bottom: MediaQuery.of(context).size.height * 0.05,
      child: PinterestMenu(
        show: show,
        activeColor:
            theme.darkTheme ? theme.currentTheme.accentColor : Colors.blue,
        inactiveColor: theme.darkTheme
            ? theme.currentTheme.primaryColor.withOpacity(1)
            : Colors.blueGrey,
        items: [
          PinterestButton(
            Icons.pie_chart,
            () {},
          ),
          PinterestButton(
            Icons.people,
            () {},
          ),
          PinterestButton(
            Icons.notification_important,
            () {},
          ),
          PinterestButton(
            Icons.picture_in_picture,
            () {},
          ),
        ],
      ),
    );
  }
}

class PinterestGrid extends StatefulWidget {
  final Color color;

  PinterestGrid({this.color = Colors.pink});

  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List items = List.generate(200, (index) => index);
  ScrollController controller = new ScrollController();
  double previousScroll = 0;

  @override
  void initState() {
    Provider.of<_MenuModel>(context, listen: false).gridColor = widget.color;

    controller.addListener(() {
      if (controller.offset > previousScroll) {
        print('Hide menu');
        Provider.of<_MenuModel>(context, listen: false).show = false;
      } else {
        print('Show menu');
        Provider.of<_MenuModel>(context, listen: false).show = true;
      }
      previousScroll = controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = MediaQuery.of(context).size.width >= 500 ? 3 : 2;

    return StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: count,
      itemCount: items.length,
      itemBuilder: (context, index) => _PinterestItem(index),
      staggeredTileBuilder: (index) => StaggeredTile.count(
        1,
        index.isEven ? 2 : 3,
      ),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;

  _PinterestItem(this.index);

  @override
  Widget build(BuildContext context) {
    final menuModel = Provider.of<_MenuModel>(context);

    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: menuModel.gridColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('$index'),
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  bool _show = true;
  Color _gridColor = Colors.blue;

  bool get show => this._show;

  set show(bool show) {
    this._show = show;
    notifyListeners();
  }

  Color get gridColor => this._gridColor;

  set gridColor(Color color) {
    this._gridColor = color;
  }
}
