import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion/motion.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:portfolio/view/root.dart';

 
void main()async {

  WidgetsFlutterBinding.ensureInitialized(); 
  await Motion.instance.initialize();
  Motion.instance.setUpdateInterval(60.fps);

  runApp(ProviderScope(child: const AppTheme()));


}

class AppTheme extends StatelessWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PORTFOLIO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors().primaryColor,
      ),
      home: const RootScreen(),
    );
  }
}
