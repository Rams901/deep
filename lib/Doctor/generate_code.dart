import 'package:flutter/material.dart';
import 'patientlist.dart';
import 'navDoctor.dart';
// import 'package:meditation_app/Components/PatientSide/bottom_nav_bar.dart';
import '../constants.dart';
class Code extends StatefulWidget {
  const Code({ Key? key }) : super(key: key);

  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  var pclass = [    
    'Depression',
    'Anxiety',
    'Family Issues',
  ];
  String dropdownvalue = 'Depression';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      bottomNavigationBar: BottomNavBarD(),
      appBar: 
       AppBar(
         backgroundColor: Colors.white,elevation: 0,
         title: Text("Add Patient", style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w700),),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back,size: 35,color:kBlueLight,), onPressed: () {  
                       
            },),
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
body: Container(
  child:Column(
    children:  <Widget>[


Padding(
  padding: const EdgeInsets.all(12),
  child:   Text("Generate a one-time use code for a new patient. Send the code to the new patient you wish to add.", style:TextStyle(fontWeight: FontWeight.bold,fontSize:17,color: Colors.black)),
),


 Padding(
   padding: const EdgeInsets.only(left:12.0),
   child: Text("Do note that the code is valid for 24 hours.Once it’s used, a new patient will be added to your list.", style:TextStyle(fontWeight: FontWeight.bold,fontSize:17,color: Colors.black54,)),
 ),
    
             Padding(
               padding: const EdgeInsets.all(30.0),
               child: Column(children: [ElevatedButton(child: Text('Generate Code',style:TextStyle(fontWeight: FontWeight.w800,fontSize: 20)),
            style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF3672CE)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(400, 50)),
                    
            
                       
                        ),
            onPressed: () {
                 
                               
                                },
            ),DropdownButton(isExpanded: true,
                
              // Initial Value
              value: dropdownvalue,
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: pclass.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) { 
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),]
             )),

Container(
height: 50,
width: 370,
decoration: BoxDecoration(
  border: Border.all(
      color: Colors.grey,                   
)),
),



   Padding(
     padding: const EdgeInsets.only(right:160.0,top:30),
     
     child: Text("Patients Registred :   5"     , style:TextStyle(color: Colors.blue,fontSize: 17,fontWeight: FontWeight.bold)),
   ),
  Padding(
    padding: const EdgeInsets.only(right:120.0,top:8),
    child: Text("Number of patients left :   10"     , style:TextStyle(color: Colors.blue,fontSize: 17,fontWeight: FontWeight.bold)),
  ),



Padding(
    padding: const EdgeInsets.only(top:118,left:30,right: 30),
    child:RichText(
                 
                         text: TextSpan(
                   /*defining default style is optional */
                  children: 
                  <TextSpan>[
                    TextSpan(text:'You’re reaching the limit? ', style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                    TextSpan(text:' Upgrade your  membership', style: TextStyle(color:Colors.blue,fontSize: 15,fontWeight: FontWeight.bold)),
  
                  ])))
]
  )
),
    );}}