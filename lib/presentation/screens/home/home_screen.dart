import 'package:flutter/material.dart';
import 'package:geppetto_mobile/config/menu/menu_items.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/logo-gpto.svg',
              width: 45,
            ),
            const Text(
              "GEPPETTO",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        )),
        body: const _HomeView());
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder: (context, index) {
        return _CustomButton(index: index);
      },
    );
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 200, height: 100),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          onPressed: () {
            context.push(appMenuItems[index].link);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    appMenuItems[index].icon,
                    color: theme.primary,
                    size: 40.0,
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appMenuItems[index].title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(appMenuItems[index].subTitle),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: theme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
