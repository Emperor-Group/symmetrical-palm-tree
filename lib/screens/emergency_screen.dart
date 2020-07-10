import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:headers/widgets/emergency/custom_card.dart';
import 'package:headers/widgets/headers/icon_header.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;

  ItemBoton(this.icon, this.texto, this.color1, this.color2);
}

class EmergencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = <ItemBoton>[
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
    ];

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height > 500 ? 220 : 10),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                ...items
                    .map(
                      (e) => FadeInLeft(
                        duration: Duration(milliseconds: 1000),
                        child: CustomCard(
                          icon: e.icon,
                          text: e.texto,
                          color1: e.color1,
                          color2: e.color2,
                          onPress: () {},
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
          ),
          if (MediaQuery.of(context).size.height > 500) _Header()
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconHeader(
          icon: FontAwesomeIcons.briefcaseMedical,
          title: 'Haz Solicitado',
          subtitle: 'Asistencia Médica',
          color1: Colors.blue[300],
          color2: Colors.blue[700],
        ),
        Positioned(
          right: 10,
          top: 20,
          child: RawMaterialButton(
            onPressed: () {},
            shape: CircleBorder(),
            child: FaIcon(
              FontAwesomeIcons.ellipsisV,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCardTemp extends StatelessWidget {
  const CustomCardTemp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      icon: FontAwesomeIcons.carCrash,
      secondaryIcon: FontAwesomeIcons.chevronRight,
      text: 'Car Accident',
      color1: Colors.purple[300],
      color2: Colors.purple[700],
      onPress: () {
        print('Tap');
      },
    );
  }
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconHeader(
      icon: FontAwesomeIcons.plusCircle,
      title: 'Haz Solicitado',
      subtitle: 'Asistencia médica',
      color1: Color(0xff526Bf6),
      color2: Color(0xff67ACF2),
    );
  }
}
