import 'dart:ui';
import 'package:flutter/material.dart';

/**
 *@author  Imen chihaoui && Ramzi  afli
 *@noteapi  custimizing  more and  more  the  hover  animation of  add  medication button
 */


class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({
    @required WidgetBuilder ? builder,
    RouteSettings ? settings,
    bool fullscreenDialog = false,
  })  : _builder  = builder !,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}