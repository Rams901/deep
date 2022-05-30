import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';





import '../../../constants.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({Key key}) : super(key: key);

//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {

//    int _currentIndex=0;
//   List _screens=[HomeScreen(),Chat(),HomeQuiz(),profilePatient()];

// void _updateIndex(int value) {
//     setState(() {
//       _currentIndex = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//        return Scaffold(
//                body: _screens[_currentIndex],
//  bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _currentIndex,
//         onTap: _updateIndex,
//         selectedItemColor: Colors.blue[700],
//         selectedFontSize: 13,
//         unselectedFontSize: 13,
//         iconSize: 30,
//         items: [
//           BottomNavigationBarItem(
//             label: "Home",
//             icon: Icon(Icons.home),

//           ),
//           BottomNavigationBarItem(
//             label: "Search",
//             icon: Icon(Icons.search),
//           ),
//           BottomNavigationBarItem(
//             label: "Categories",
//             icon: Icon(Icons.grid_view),
//           ),
//           BottomNavigationBarItem(
//             label: "My Account",
//             icon: Icon(Icons.account_circle_outlined),
//           ),
//         ],
//       ),
//     );
//   }


// }
       
       
 
  







class BottomNavBar extends StatelessWidget {

  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          
          BottomNavItem(
            
            title: "Home",
            svgScr:  ["assets/icons/home01.svg", "assets/icons/Home02.svg"],
            //Aaaa, ntkalm rani, ane nesmae fik
            // hhhh
            // netkalaam
            // leeee, nty heya mla
             press: () {
               print("working");
               
                                
                              },
          ),

         
          BottomNavItem(
            title: "chat",
            svgScr: ["assets/icons/chat01.svg","assets/icons/chat02.svg"],
            press: () {
               
                              
                            //Get.to(ChatsScreen());
                                
                              },
            
          ),
           BottomNavItem(
            title: "Quiz",
            svgScr: ["assets/icons/quiz.svg","assets/icons/quiz01.svg"],
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
        print("hi");
        isActive = true;
        

      },
      child: Container(width: 65,child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(isActive ? svgScr![1] : svgScr![0],width: 25, height: 30,
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
