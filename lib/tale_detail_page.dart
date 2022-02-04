import 'package:flutter/material.dart';
import 'package:flutter_colosseum/tale_text.dart';
import 'package:google_fonts/google_fonts.dart';

class TaleDetailPage extends StatefulWidget {
  const TaleDetailPage({
    Key? key,
    required this.tale,
  }) : super(key: key);

  final Tale tale;

  @override
  _TaleDetailPageState createState() => _TaleDetailPageState();
}

class _TaleDetailPageState extends State<TaleDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController? _controller;
  late Animation<double> _colorGradientValue;
  late Animation<double> _whiteGradientValue;

  late bool _changeToBlack;
  late bool _enableInfoItems;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _colorGradientValue = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
        parent: _controller!,
      ),
    );

    _whiteGradientValue = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        curve: const Interval(0.1, 1, curve: Curves.fastOutSlowIn),
        parent: _controller!,
      ),
    );

    _changeToBlack = false;
    _enableInfoItems = false;

    Future.delayed(const Duration(milliseconds: 600), () {
      _controller!.forward();
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _changeToBlack = true;
        });
      });
    });

    _controller!.addStatusListener(_statusListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller!
      ..removeStatusListener(_statusListener)
      ..dispose();
    super.dispose();
  }

  //----------------------------------------
  // Status Listener
  //----------------------------------------
  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _enableInfoItems = true;
      });
    }
  }

  //-----------------------
  // On Back Button Tap
  //-----------------------
  Future<void> _backButtonTap() async {
    setState(() {
      _enableInfoItems = false;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _changeToBlack = false;
      });
    });
    _controller!.reverse().then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: Stack(
        children: [
          //-------------------------
          // Animated Background
          //-------------------------
          Positioned.fill(
            child: Hero(
              tag: "${widget.tale.taleName}background",
              child: AnimatedBuilder(
                animation: _controller!,
                builder: (_, __) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(widget.tale.rawColor!), Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          _colorGradientValue.value,
                          _whiteGradientValue.value
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          //----------------------
          // Основное тело
          //----------------------
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //---------------------
                // Картинка рассказа
                //---------------------
                Dismissible(
                  direction: DismissDirection.vertical,
                  key: UniqueKey(), //Key('tale ${tales[index]}'),
                  onDismissed: (DismissDirection direction) {
                    if (direction == DismissDirection.down) {
                      print("Закрываю рассказ");
                      _backButtonTap;
                    }
                    setState(() {
                      _backButtonTap();
                    });
                  },
                  child: Container(
                    width: 1000,
                    height: 40,
                    margin: const EdgeInsets.only(top: 50),
                    child: Image.asset(
                      'assets/swipe_gif/swipe_down.gif',
                      height: 30,
                      width: 30,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                SafeArea(
                  child: Hero(
                    tag: widget.tale.pathImage!,
                    child: Image.asset(
                      widget.tale.pathImage!,
                      height: size.height * .55,
                      width: size.width,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10), //это ширина текста внутри карточки//
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //--------------------------
                      // Название рассказа
                      //--------------------------
                      Align(
                        heightFactor: 2, //отступ сверху, между элементами//
                        alignment: Alignment.bottomLeft,
                        child: FittedBox(
                          child: Hero(
                            tag: widget.tale.taleName!,
                            child: AnimatedDefaultTextStyle(
                              duration: kThemeAnimationDuration,
                              style: textTheme.headline2!.copyWith(
                                color: _changeToBlack
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              child: Text(
                                widget.tale.taleName!,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //---------------------------------------
                          // Эпизод рассказа
                          //---------------------------------------
                          Hero(
                            tag: widget.tale.episode!,
                            child: AnimatedDefaultTextStyle(
                              duration: kThemeAnimationDuration,
                              style: textTheme.headline5!.copyWith(
                                color: _changeToBlack
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              child: Text(
                                widget.tale.episode!,
                              ),
                            ),
                          ),
                          //--------------------------
                          // Анимированное лого (чтобы его добавить надо: 1. Раскомментировать код ниже, 2. В строку assets вставить названия своего логотипа)
                          //--------------------------
                          TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.fastOutSlowIn,
                            tween: Tween(
                              begin: 0,
                              end: _enableInfoItems ? 1.0 : 0.0,
                            ),
                            builder: (context, dynamic value, child) {
                              return Transform.scale(
                                scale: value,
                                child: child,
                              );
                            },
                            /*child: Image.asset(
                              'assets/img/',
                              height: 35,
                              width: 100,
                            ),*/
                          )
                        ],
                      ),
                      const Divider(height: 30),
                      //---------------------------------------
                      // Текст рассказа
                      //---------------------------------------
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        transform: Matrix4.translationValues(
                          0,
                          _enableInfoItems ? 0 : 50,
                          0,
                        ),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _enableInfoItems ? 1.0 : 0.0,
                          child: Text(
                            widget.tale.description!,
                            style: GoogleFonts.spartan(
                              color: Colors.black,
                              height: 1.5,
                              fontSize: 17, //размер шрифта//
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 3004, //здесь колличество строк текста//
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      /*const Divider(height: 30),
                      //----------------------------------
                      // Section Movies Title
                      //----------------------------------
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        transform: Matrix4.translationValues(
                          0,
                          _enableInfoItems ? 0 : 50,
                          0,
                        ),
                        /*child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: _enableInfoItems ? 1.0 : 0.0,
                          child: Text(
                            '',
                            style: textTheme.headline5!
                                .copyWith(color: Colors.black),
                          ),
                        ),*/
                      ),*/
                    ],
                  ),
                ),
                //----------------------------
                // Superhero movies list
                //----------------------------
                /*SizedBox(
                  height: 240,
                  child: ListView.builder(
                    //itemCount: widget.superhero.movies!.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      //final movie = widget.superhero.movies![index];
                      //---------------------------
                      // Animated Movie Card
                      //---------------------------
                      return TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 1000 + (300 * index)),
                        curve: Curves.elasticOut,
                        tween: Tween(
                          begin: 0,
                          end: _enableInfoItems ? 0.0 : 1.0,
                        ),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 50 * value),
                            child: Opacity(
                              opacity: 1 - value.clamp(0.0, 1.0),
                              child: child,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            //child: CachedNetworkImage(imageUrl: movie.urlImage),
                          ),
                        ),
                      );
                    },
                  ),
                )*/
              ],
            ),
          ),
          //-------------------------
          // Back Button
          //-------------------------
          Dismissible(
            /*left: 20,
            top: 0,
            child: SafeArea(
              child: IconButton(
                onPressed: _backButtonTap,
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            */
            direction: DismissDirection.vertical,
            key: UniqueKey(), //Key('tale ${tales[index]}'),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.down) {
                print("Закрываю рассказ");
                _backButtonTap;
              }
              setState(() {
                _backButtonTap();
              });
            },
            child: const SizedBox(
              height: 150,
              width: 1000,
            ),
          ),
        ],
      ),
    );
  }
}
