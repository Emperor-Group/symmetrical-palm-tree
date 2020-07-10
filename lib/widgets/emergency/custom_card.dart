import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final IconData secondaryIcon;
  final String text;
  final Color color1;
  final Color color2;
  final Function onPress;

  const CustomCard({
    @required this.icon,
    this.secondaryIcon = FontAwesomeIcons.chevronRight,
    @required this.text,
    this.color1 = Colors.lightBlue,
    this.color2 = Colors.blue,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: <Widget>[
          _CardBackground(
            color1: this.color1,
            color2: this.color2,
            icon: this.icon,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 140,
                width: 40,
              ),
              FaIcon(
                this.icon,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  this.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              FaIcon(
                this.secondaryIcon,
                color: Colors.white,
              ),
              SizedBox(
                width: 40,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _CardBackground extends StatelessWidget {
  final IconData icon;
  final Color color1;
  final Color color2;

  const _CardBackground({
    @required this.icon,
    @required this.color1,
    @required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(-5, 5),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            this.color1,
            this.color2,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -20,
              top: -20,
              child: FaIcon(
                this.icon,
                size: 150,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
