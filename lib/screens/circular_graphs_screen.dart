import 'package:flutter/material.dart';
import 'package:headers/themes/theme.dart';
import 'package:headers/widgets/progress/radial_progress.dart';
import 'package:provider/provider.dart';

class CircularGraphsScreen extends StatefulWidget {
  const CircularGraphsScreen({Key key}) : super(key: key);

  @override
  _CircularGraphsScreenState createState() => _CircularGraphsScreenState();
}

class _CircularGraphsScreenState extends State<CircularGraphsScreen> {
  double percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(
                percentage: percentage * 1,
                color: Colors.blue,
              ),
              CustomRadialProgress(
                percentage: percentage * 1.2,
                color: Colors.deepPurple,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(
                percentage: percentage * 2.5,
                color: Colors.green,
              ),
              CustomRadialProgress(
                percentage: percentage * 3,
                color: Colors.pink,
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            percentage += 0.1;
            if (percentage > 1) {
              percentage = 0.0;
            }
          });
        },
        child: Icon(
          Icons.refresh,
        ),
      ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  final Color color;

  const CustomRadialProgress({
    @required this.percentage,
    @required this.color,
  });

  final double percentage;

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);

    return Container(
      width: 150,
      height: 150,
      child: RadialProgress(
        percentage: percentage,
        primaryColor: color,
        secondaryColor: appTheme.darkTheme ? Colors.white : Colors.black,
        secondaryWidth: 10,
        primaryWidth: 5,
        separation: 0,
      ),
    );
  }
}
