import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_colosseum/tale_text.dart';

class TaleCard extends StatelessWidget {
  const TaleCard({
    Key? key,
    required this.tale,
    required this.factorChange,
  }) : super(key: key);

  final Tale tale;
  final double? factorChange;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final separation = size.height * .24;
    return OverflowBox(
      alignment: Alignment.topCenter,
      maxHeight: size.height,
      child: Stack(
        children: [
          //--------------------------------------------
          // Color bg with rounded corners
          //--------------------------------------------
          Positioned.fill(
            top: separation,
            child: Hero(
              tag: "${tale.taleName}background",
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(tale.rawColor!),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          //-----------------------------------
          // Картинка рассказа
          //-----------------------------------
          Positioned(
            left: 20,
            right: 20,
            top: separation * factorChange!,
            bottom: size.height * .35,
            child: Opacity(
              opacity: 1.0 - factorChange!,
              child: Transform.scale(
                scale: lerpDouble(1, .4, factorChange!)!,
                child: Hero(
                  tag: tale.pathImage!,
                  child: Image.asset(tale.pathImage!),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            right: 100,
            top: size.height * .65, //отступ от картинки главная страница//
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //----------------------------------
                // Название рассказа
                //----------------------------------
                FittedBox(
                  child: Hero(
                    tag: tale.taleName!,
                    child: Text(
                      tale.taleName!,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                //----------------------------------
                // Эпизод рассказа
                //----------------------------------
                Hero(
                  tag: tale.episode!,
                  child: Text(
                    tale.episode!,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 60),
                  child: Image.asset(
                    'assets/swipe_gif/swipe_up.gif',
                    height: 50,
                    width: 50,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
