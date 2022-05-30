import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



import '/constants.dart';



class BottomNavBarD extends StatelessWidget {
  const BottomNavBarD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: "Home",
            svgScr:  ["assets/icons/home01.svg", "assets/icons/Home02.svg"],
            
             press: () {
            
                              
                                
                              },
          ),

        
          BottomNavItem(
            title: "chat",
            svgScr: ["assets/icons/chat01.svg","assets/icons/chat02.svg"],
             press: () {
               
                               
                              },
          ),
           BottomNavItem(
            title: "search",
            svgScr: ["assets/icons/chercher.svg","assets/icons/chercher.svg"],
             press: () {
               
                                
                              },
           
          ),
           BottomNavItem(
            title: "profile",
            svgScr: ["assets/icons/user01.svg","assets/icons/user02.svg"],
             press: () {
               
                                
                              },
    
            
          ),

          
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final List<String>? svgScr;
  final String? title;
  final Function? press;
   bool isActive;
   BottomNavItem({
    Key? key,
    this.svgScr,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        isActive = true;
               

      },
      child: Container(width: 65,child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(isActive ? svgScr![1] : svgScr![0],width: 25, height: 35,
            color: isActive ?  kTextColor : kBlueLightColor,
          ),
          Text(
            title!,
            style: TextStyle(color: isActive ?   kTextColor
            :kBlueLightColor),
          ),
        ],
      ),),
    );
  }
}
