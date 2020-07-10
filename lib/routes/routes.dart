import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:headers/screens/slide_show_screen.dart';
import 'package:headers/screens/animations_screen.dart';
import 'package:headers/screens/circular_graphs_screen.dart';
import 'package:headers/screens/emergency_screen.dart';
import 'package:headers/screens/headers_screen.dart';
import 'package:headers/screens/pinterest_screen.dart';
import 'package:headers/screens/sliver_list_screen.dart';

final List<_Route> pageRoutes = [
  _Route(FontAwesomeIcons.slideshare, 'Slide-Show', SlideShowScreen()),
  _Route(FontAwesomeIcons.ambulance, 'Emergency', EmergencyScreen()),
  _Route(FontAwesomeIcons.heading, 'Headers', HeadersScreen()),
  _Route(FontAwesomeIcons.peopleCarry, 'Animated Square', AnimationsScreen()),
  _Route(FontAwesomeIcons.circleNotch, 'Progress Bar', CircularGraphsScreen()),
  _Route(FontAwesomeIcons.pinterest, 'Pinterest', PinteresScreen()),
  _Route(FontAwesomeIcons.list, 'Slivers', SliverListScreen()),
];

class _Route {
  final IconData icon;
  final String title;
  final Widget screen;

  _Route(
    this.icon,
    this.title,
    this.screen,
  );
}
