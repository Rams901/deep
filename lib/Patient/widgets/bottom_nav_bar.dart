import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: "Home",
            svgScr: "lib/assets/icons/home01.svg", 
            isActive: true,
          ),
          BottomNavItem(
            title: "chat",
            svgScr: "lib/assets/icons/chat01.svg",
            
          ),
           BottomNavItem(
            title: "Quiz",
            svgScr: "lib/assets/icons/quiz.svg",
           
          ),
           BottomNavItem(
            title: "profile",
            svgScr: "lib/assets/icons/user01.svg",
    
            
          ),

          
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String? svgScr;
  final String? title;
  final Function? press;
  final bool isActive;
  const BottomNavItem({
    Key? key,
    this.svgScr,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){press;},
      child: Container(width: 65,child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(svgScr,width: 35, height: 40,
            color: isActive ?  kTextColor : kBlueLightColor,
          ),
          Text(
            title!,
            style: TextStyle(color: isActive ?   kTextColor
            :kBlueLightColor),
          ),
        ],
      ), color: isActive? Colors.grey[350] : Colors.white),
    );
  }
}
