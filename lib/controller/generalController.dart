import 'package:flutter_riverpod/flutter_riverpod.dart';

var hoverProvider = StateProvider<String>((ref) => "");

var scrollControlProvider = StateProvider<bool>((ref) => true);

var selectedExpProvider = StateProvider<int>((ref) => 0);

var progressProvider = StateProvider<bool>((ref) => false);

var currentMenuIndexProvider = StateProvider<int>((ref) => -1);

var introName = StateProvider<bool>((ref) => false);