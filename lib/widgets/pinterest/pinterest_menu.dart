import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final Function onPressed;
  final IconData icon;

  PinterestButton(
    this.icon,
    this.onPressed,
  );
}

class PinterestMenu extends StatelessWidget {
  final bool show;
  final Color activeColor;
  final Color inactiveColor;
  final List<PinterestButton> items;

  PinterestMenu({
    this.show = true,
    this.activeColor = Colors.pink,
    this.inactiveColor = Colors.grey,
    @required this.items,
  });

  //  items = [
  //   PinterestButton(Icons.pie_chart, () {
  //     print('pie chart');
  //   }),
  //   PinterestButton(Icons.search, () {
  //     print('search');
  //   }),
  //   PinterestButton(Icons.notification_important, () {
  //     print('notify');
  //   }),
  //   PinterestButton(Icons.supervised_user_circle, () {
  //     print('user circle');
  //   }),
  // ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => _MenuModel(),
      child: Builder(builder: (context) {
        Provider.of<_MenuModel>(context, listen: false).activeColor =
            activeColor;
        Provider.of<_MenuModel>(context, listen: false).inactiveColor =
            inactiveColor;

        return AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: show ? 1 : 0,
          child: _PinteresMenuBackground(
            _MenuItems(
              items,
            ),
          ),
        );
      }),
    );
  }
}

class _PinteresMenuBackground extends StatelessWidget {
  final Widget child;

  _PinteresMenuBackground(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(200),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(
              -5,
              5,
            ),
            blurRadius: 5,
          ),
        ],
      ),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;

  _MenuItems(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ...List.generate(
          menuItems.length,
          (index) => _PinterestMenuItem(
            index,
            menuItems[index],
          ),
        ),
      ],
    );
  }
}

class _PinterestMenuItem extends StatelessWidget {
  final int index;
  final PinterestButton item;

  _PinterestMenuItem(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final menuModel = Provider.of<_MenuModel>(context);
    final selectedIndex = menuModel.selectedIndex;
    final activeColor = menuModel.activeColor;
    final inactiveColor = menuModel.inactiveColor;

    return IconButton(
      icon: Icon(
        item.icon,
        size: selectedIndex == index ? 25 : 20,
        color: selectedIndex == index ? activeColor : inactiveColor,
      ),
      onPressed: () {
        Provider.of<_MenuModel>(context, listen: false).selectedIndex = index;
        item.onPressed();
      },
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _selectedIndex = 0;
  Color _activeColor = Colors.blue;
  Color _inactiveColor = Colors.grey;

  int get selectedIndex => this._selectedIndex;

  set selectedIndex(int newIndex) {
    this._selectedIndex = newIndex;
    notifyListeners();
  }

  Color get activeColor => this._activeColor;

  set activeColor(Color color) {
    this._activeColor = color;
  }

  Color get inactiveColor => this._inactiveColor;

  set inactiveColor(Color color) {
    this._inactiveColor = color;
  }
}
