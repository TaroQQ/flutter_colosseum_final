import 'dart:math';
import 'package:flutter/material.dart';
import 'tale_card.dart';
import 'tale_text.dart';
import 'tale_detail_page.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class TaleSliderPage extends StatefulWidget {
  const TaleSliderPage({
    Key? key,
  }) : super(key: key);

  @override
  _TaleSliderPageState createState() => _TaleSliderPageState();
}

class _TaleSliderPageState extends State<TaleSliderPage> {
  PageController? _pageController;
  late int _index;
  late int _auxIndex;
  double? _percent;
  double? _auxPercent;
  late bool _isScrolling;
  bool selected = true;
  // late bool selected;

  @override
  void initState() {
    _pageController = PageController();
    _index = 0;
    _auxIndex = _index + 1;
    _percent = 0.0;
    _auxPercent = 1.0 - _percent!;
    _isScrolling = false;
    _pageController!.addListener(_pageListener);
    super.initState();
    //selected = _incrementCounterIcon();
  }

  @override
  void dispose() {
    _pageController!
      ..removeListener(_pageListener)
      ..dispose();
    super.dispose();
  }

  //--------------------------
  // Page View Listener
  //--------------------------
  void _pageListener() {
    _index = _pageController!.page!.floor();
    _auxIndex = _index + 1;
    _percent = (_pageController!.page! - _index).abs();
    _auxPercent = 1.0 - _percent!;
    _isScrolling = _pageController!.page! % 1.0 != 0;
    setState(() {});
  }

  /* _incrementCounter(bool selectIcon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('counter', selectIcon);
  }

  _incrementCounterIcon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var IconTest = await prefs.getBool('counter') ?? false ? true : false;
    return IconTest;
  }
*/
  @override
  Widget build(BuildContext context) {
    const tales = Tale.taleEpisode;
    const angleRotate = -pi * .5;
    return Scaffold(
      //---------------
      // Верхняя панель
      //---------------
      appBar: AppBar(
        title: const Text("МИР КОЛИЗЕЯ"), //верхняя надпись//
        elevation: 0,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: Text(
                'ОГЛАВЛЕНИЕ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 4,
                ),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(color: Colors.white70),
            ),
            // ListTile(title: const Text("1 ЭПИЗОД"), onTap: () {Navigator.of(context).pop(); _openDetail(context, tales[0]);}),
            // КОПИРУЕМ СТРОЧКУ СВЕРХУ И ВСТАВЛЯЕМ ПОСЛЕ ЗАПЯТОЙ КАК ПОКАЗАНО НИЖЕ. ВОТ ТУТ tales[0] СТАВИМ ТО ЧИСЛО КОТОРОЕ НАМ НУЖНО
            /*ListTile(
                leading: IconButton(
                    icon: selected
                        ? const Icon(Icons.library_books)
                        : const Icon(
                            Icons.done,
                          ),
                    onPressed: () {
                      setState(() {
                        // Here we changing the icon.
                        selected = !selected;
                        //_incrementCounter(selected);
                      });
                    }),
                title: const Text("1 ЭПИЗОД"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[0]);
                }),*/
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("1 Однажды утром"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[0]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("2 Встреча"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[1]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("3 Цвет Надежды"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[2]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("4 Завтрак"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[3]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("5 Время и его причуды"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[4]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("6 Прометей"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[5]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("7 Внутренний огонь"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[6]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("8 Скамейка"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[7]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("9 Колодец"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[8]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("10 Паритет"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[9]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("11 Обыкновенный вечер"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[10]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("12 Ночь, дорога, навигатор"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[11]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("13 Путь в никуда"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[12]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("14 Изумрудный город... сейчас"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[13]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("15 Отражение"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[14]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("16 Свет мой, зеркальце..."),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[15]);
                }),
            ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text("17 Переподготовка зла, или Что-то новое…"),
                onTap: () {
                  Navigator.of(context).pop();
                  _openDetail(context, tales[16]);
                }),
          ],
        ),
      ),

      body: Stack(
        children: [
          //-----------------------
          // Tale Cards
          //-----------------------
          AnimatedPositioned(
            duration: kThemeAnimationDuration,
            top: 0,
            bottom: 0,
            right: _isScrolling ? 10 : 0,
            left: _isScrolling ? 10 : 0,
            child: Stack(children: [
              //----------------
              // Back Card
              //----------------
              Transform.translate(
                offset: Offset(0, 50 * _auxPercent!),
                child: TaleCard(
                  tale: tales[_auxIndex.clamp(0, tales.length - 1)],
                  factorChange: _auxPercent,
                ),
              ),

              //----------------
              // Front Card
              //----------------
              Transform.translate(
                offset: Offset(-800 * _percent!, 100 * _percent!),
                child: Transform.rotate(
                  angle: angleRotate * _percent!,
                  child: TaleCard(
                    tale: tales[_index],
                    factorChange: _percent,
                  ),
                ),
              ),
            ]),
          ),
          //-----------------------------------------------------
          // VOID PAGE VIEW
          // This page view is just for using the page controller
          //-----------------------------------------------------
          PageView.builder(
            controller: _pageController,
            itemCount: tales.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.vertical,
                key: UniqueKey(), //Key('tale ${tales[index]}'),
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.up) {
                    print("Открываю рассказ");
                    _openDetail(context, tales[index]);
                  }
                  setState(() {
                    () => _openDetail(context, tales[index]);
                  });
                },
                //onTap: () => _openDetail(context, tales[index]),
                child: const SizedBox(),
              );
            },
          )
        ],
      ),
    );
  }

  void _openDetail(BuildContext context, Tale tale) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: TaleDetailPage(
              tale: tale,
            ),
          );
        },
      ),
    );
  }
}
