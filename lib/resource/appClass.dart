import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:portfolio/model/models.dart';
import 'package:portfolio/resource/styles.dart';
import 'package:url_launcher/url_launcher.dart';


enum ScreenType { mobile, tab, web }

class AppClass {
  static final AppClass _mAppClass = AppClass._internal();
  static BuildContext? lastContext;
  ScrollController controller = ScrollController();

  /* URL */
  static final resumeDownloadURL =
      '''https://drive.google.com/file/d/1AUj8qNucPEsacLZ92XNBr62F9Dh99Nq2/view?usp=share_link''';
 
  List<WorkModel> projectList = [
    WorkModel(
        projectTitle: "Quick Swappers",
        projectContent:
            "assets/svg/quick_swapper.png",
        tech1: "Android",
        tech2: "IOS",
        tech3: "Node.js"),
    WorkModel(
        projectTitle: "Quick Biznes",
        projectContent:
            "assets/svg/quick_biznes.png",
            
        tech1: "Android",
        tech2: "IOS", tech3: "Node.js"),
    WorkModel(
        projectTitle: "Launch Arts Media",
        projectContent:
            '''assets/svg/launchartmedia.png''',
        tech1: "Android",
        tech2: "IOS",
        tech3: "Node.js"),
    WorkModel(
        projectTitle: "Pharmapedia Pro",
        projectContent:
            '''assets/svg/pharma.png''',
        tech1: "Android",
        tech2: "IOS"),
    WorkModel(
        projectTitle: "Ward Guide",
        projectContent:
            '''assets/svg/ward.png''',
        tech1: "Flutter",
        tech2: "NodeJs",
        tech3: "IOS"),
    WorkModel(
        projectTitle: "Aqary International App",
        projectContent:
            '''assets/svg/aqary.png''',
        tech1: "Android",
        tech2: "IOS", tech3: "Golang"),
  ];

  factory AppClass() {
    return _mAppClass;
  }

  AppClass._internal();

  getMqWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  getMqHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  showSnackBar(String msg, {BuildContext? context}) {
    ScaffoldMessenger.of(context ?? lastContext!)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  ScreenType getScreenType(BuildContext context) {
    double scrWidth = getMqWidth(context);
    if (scrWidth > 915) {
      return ScreenType.web;
    } else if (scrWidth < 650) {
      return ScreenType.mobile;
    }
    return ScreenType.tab;
  }

  downloadResume(context) async {
    await launchUrl(Uri.parse(AppClass.resumeDownloadURL));
  }

  alertDialog(context, title, msg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: Text(title, style: TxtStyle().boldWhite(context)),
                content: Text(msg),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () => Navigator.pop(context),
                      child: Text('Okay'))
                ]));
  }

   sendEmail(name, contact, msg) async {
    // var url = Uri.https('hbk-portfolio-mailer.web.app', '/sendMail');
    // var response = await post(url, body: {
    //   "name": name,
    //   "contactInfo": contact,
    //   "message": msg
    // }).timeout(Duration(seconds: 10));
    // print(response.body);
    // return response.statusCode == 200;
  }
}
