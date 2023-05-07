import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/view/root.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../resource/appClass.dart';
import '../../resource/colors.dart';
import '../../resource/strings.dart';

class IntroMobile extends StatefulWidget {
  final AutoScrollController aScrollController;

  IntroMobile(this.aScrollController, {Key? key}) : super(key: key);

  @override
  State<IntroMobile> createState() => _IntroMobileState();
}

class _IntroMobileState extends State<IntroMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: AppClass().getMqHeight(context) - 50,
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.welcomeTxt,
                style: TextStyle(
                    color: AppColors().neonColor,
                    fontSize: 17,
                    fontFamily: 'sfmono'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Text(
                      Strings.firstName,
                      style: GoogleFonts.robotoSlab(
                        color: AppColors().textColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        fontSize: 25,
                      ),
                    ),
                     InkWell(
                      onTap: ()
                      {
                        
                       if( pointerSizeController.status == AnimationStatus.completed){

                        togglePointerSize(false);
                       }else{
 togglePointerSize(true);
                       }},
                
                child: Text(
                  Strings.lastName,
                  style: GoogleFonts.robotoSlab(
                    color: AppColors().textColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    fontSize: 25,
                  ),
                ),
              ),
                  ],
                ),
              ),
             
                Container(
                height: AppClass().getMqHeight(context) * .1,
                    width: AppClass().getMqWidth(context),
                    padding: EdgeInsets.only(top: 5),
                child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                 
                    Text(
                    Strings.whatIdo0,
                    style: GoogleFonts.robotoSlab(
                    color: AppColors().textLight,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    fontSize: 20,
                    ),
                  ),
                
                  DefaultTextStyle(
                   style: GoogleFonts.robotoSlab(
                      color: AppColors().textLight,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      fontSize: 20,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        RotateAnimatedText(Strings.whatIdo1),
                        RotateAnimatedText(Strings.whatIdo2),
                        RotateAnimatedText(Strings.whatIdo3),
                        RotateAnimatedText(Strings.whatIdo4),
                        RotateAnimatedText(Strings.whatIdo5)
                      ],
                      onTap: () {
                        
                      },
                    ),
                  ),
                ],
              ),
              ),
            
              // Container(
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 5.0),
              //     child: Text(
              //       Strings.whatIdo,
              //       style: GoogleFonts.robotoSlab(
              //         color: AppColors().textLight,
              //         fontWeight: FontWeight.bold,
              //         letterSpacing: 3,
              //         fontSize: 24,
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  child: RichText(
                      text: TextSpan(
                          text: Strings.introAbout,
                          style: GoogleFonts.roboto(
                            color: AppColors().textLight,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 17,
                          ),
                          children: <TextSpan>[
                        TextSpan(
                          text: Strings.currentOrgName,
                          style: GoogleFonts.roboto(
                            color: AppColors().neonColor,
                            letterSpacing: 1,
                            height: 1.5,
                            fontSize: 17,
                          ),
                        )
                      ])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: InkWell(
                  onTap: () {
                    widget.aScrollController.scrollToIndex(1,
                        preferPosition: AutoScrollPosition.begin);
                  },
                  child: Container(
                    height: AppClass().getMqHeight(context) * 0.07,
                    width: AppClass().getMqWidth(context) * 0.5,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        border: Border.all(
                            color: AppColors().neonColor, width: 1.5)),
                    child: Center(
                      child: Text('Check Out My Work!',
                          style: TextStyle(
                              color: AppColors().neonColor,
                              fontSize: 13,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'sfmono')),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
