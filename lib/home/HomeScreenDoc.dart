import 'package:flutter/material.dart';
import '../Components/PatientSide/ChatScreen.dart';
import '../Doctor/patientList.dart';
import '../Doctor/navDoctor.dart';

import '../constants.dart';

class home extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      bottomNavigationBar: BottomNavBarD(),
      appBar: 
       AppBar(
         backgroundColor: Colors.white,elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.notifications,size: 35,color:kBlueLight,), onPressed: () {  },),
        actions: <Widget>[
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: CircleAvatar(backgroundColor: Colors.white,
    radius: 35.0,
    child: ClipRRect(
      
        child: Image.asset("assets/images/doctor.png"),
        borderRadius: BorderRadius.circular(30.0),
   )),
         ),
        ],
        

    ),
// flutter run -v
body:
  Container(
  
  height: 700,
    
  

  
  child:
Column(children: [
  
   Padding(
     padding: const EdgeInsets.only(top:18),
     child: Text("Track your patients ",style:TextStyle(color:kTextColor , fontSize: 20 , fontWeight: FontWeight.bold)),
   ),
  
   Padding(
     padding: const EdgeInsets.only(left:30.0,top:8),
     child: Text("Catch up with your patients using chat or \n by scheduling   on online /group therapy session ",style:TextStyle(color:Colors.grey , fontSize: 15 , fontWeight: FontWeight.w400)),
   ),
Padding(
  padding: const EdgeInsets.only(top:20.0),
   
child:ElevatedButton(child: Text('Patients List  ',style:TextStyle(fontWeight: FontWeight.w700,fontSize: 15)),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF4E8BFF)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                         side: new BorderSide(color: Color(0xFF4E8BFF))

                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(150, 40)),
                  
            
                     
                      ),
            onPressed: () { }
             
            ),


),
Padding(
  padding: const EdgeInsets.only(top:12.0),
   child:Row(children: [



Padding(
  padding: const EdgeInsets.only(left:48.0),
  child:   ElevatedButton(child: Text('Online sessions ',style:TextStyle(fontWeight: FontWeight.w700,fontSize: 15,color:Color(0xFF4E8BFF))),
  
              style: ButtonStyle(
  
                  backgroundColor: MaterialStateProperty.all(Colors.white),
  
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  
                      RoundedRectangleBorder(
  
                        borderRadius: BorderRadius.circular(15.0),
  
                                             side: new BorderSide(color: Color(0xFF4E8BFF))
  
  
  
                      ),
  
                    ),
  
                    minimumSize: MaterialStateProperty.all(Size(110, 40)),
  
                    
  
              
  
                       
  
                        ),
  
              onPressed: () {
  
                 
  
                                },
  
              ),
),
])),
Padding(
  padding: const EdgeInsets.only(left:8.0,top:10),
  child:   ElevatedButton(child: Text('Chat space ',style:TextStyle(fontWeight: FontWeight.w700,fontSize: 15)),
  
              style: ButtonStyle(
  
                  backgroundColor: MaterialStateProperty.all(Color(0xFFFFDDBE)),
  
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  
                      RoundedRectangleBorder(
  
                        borderRadius: BorderRadius.circular(15.0),
  
  
  
                      ),
  
                    ),
  
                    minimumSize: MaterialStateProperty.all(Size(160, 40)),
  
                    
  
              
  
                       
  
                        ),
  
              onPressed: () {
  
                 

                                },
  
              ),
),
Padding(
  padding: const EdgeInsets.only(right:160.0,top:36),
  child:   Image.asset("assets/images/doctorhome.png" , width:500 , height:206),
),
Container(
  width: 500 ,
  height: 10 ,
  decoration: BoxDecoration(color: Color(0xFFD1E9FF),
boxShadow: [
      BoxShadow(
        color: Color(0xFFD1E9FF).withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 3,
        offset: Offset(0, 7), // changes position of shadow
      ),
    ],
))
  ])));
}}