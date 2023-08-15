import 'package:flutter/material.dart' show IconData, Icons;

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subTitle,
      required this.link,
      required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(
      title: 'Conversion entre Bases',
      subTitle: 'Conversiones entre bases numericas',
      link: '/conversion',
      icon: Icons.transform_rounded),
  MenuItem(
      title: 'Problemas con numeros bien escritos',
      subTitle: 'Solucionador de problemas con numeros bien escritos',
      link: '/solver',
      icon: Icons.engineering_rounded),
  MenuItem(
      title: 'SolvIA',
      subTitle: 'Resolucion de problemas con GEPPETTO',
      link: '/solvia',
      icon: Icons.chat_bubble),
  // MenuItem(
  //     title: 'Explorar Conceptos',
  //     subTitle: 'Leer mas acerca de ciertos conceptos',
  //     link: '/concepts',
  //     icon: Icons.explore_rounded),
];
