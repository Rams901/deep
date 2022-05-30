import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import "../../repository/user_repository.dart";
import '../Signup-Signin.dart';
class SignupDoc2 extends StatefulWidget {
  const SignupDoc2({ Key? key }) : super(key: key);

  @override
  State<SignupDoc2> createState() => _SignupDoc2State();
}
//to add first name, last name
class _SignupDoc2State extends State<SignupDoc2> {
  static List<CountryModel> _dropdownItems = [];
  late CountryModel _dropdownValue;
  String dropdownvalue = 'Counselors/Psychotherapeutic Counsellor/ Psychotherapist';   
  // List of items in our dropdown menu
  var titles = [    
    'Chartered Psychologist',
    'Clinical Psychologist',
    'Counselling Psychologist',
    'Counselors/Psychotherapeutic Counsellor/ Psychotherapist',
    'Psychiatrist',
    'Psychoanalyst',
    'Psychologist'
  ];

  late String _errorText;
  TextEditingController phoneController = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Profile', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        leading: Image.asset("../assets/images/deep.png")
        
        // do something
      
    
  
      ),
      body: Center(child: SingleChildScrollView(child: Column(children: [SizedBox(height: 20),Container(width: 390, height: 165, decoration: new BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white, border: Border.all(color: Colors.grey, width: 1)),
      child: Center(child: Column(children: [Padding(padding:EdgeInsets.all(8),child: Stack(alignment: Alignment.center,children: [Container(width: 150, height: 100,decoration: new BoxDecoration(color: Colors.lightBlue[100], shape: BoxShape.circle),),new Icon(Icons.cloud_upload_rounded,size: 35,color: Colors.blue,)])),
      new Text("Upload Profile Picture", style: TextStyle(color: Colors.grey))]))
      ),
      Container(width: 420,padding: EdgeInsets.all(16), child: Column(children: [TextFormField(decoration: InputDecoration(labelText: 'Username'),
                  keyboardType: TextInputType.name,onChanged: (f){
                    setState(() {
                  username.text = f;
                                  });
                  },), TextFormField(decoration: InputDecoration(labelText: 'Password',), obscureText: true,
                   keyboardType: TextInputType.name,onChanged: (f){
                    setState(() {
                  password.text = f;
                                  });
                  }),TextFormField(decoration: InputDecoration(labelText: 'Confirm Password',), obscureText: true,
                   keyboardType: TextInputType.name,onChanged: (f){
                    
                  }),
                  TextFormField(decoration: InputDecoration(labelText: 'Email'),
                   keyboardType: TextInputType.emailAddress,onChanged: (f){
                    setState(() {
                  email.text = f;
                                  });
                  })
                   
                   ,_buildCountry(), _buildPhonefiled(),
                  //  TextFormField(decoration: InputDecoration(labelText: 'Phone number'),
                  //  keyboardType: TextInputType.name,),
                    DropdownButton(isExpanded: true,
                
              // Initial Value
              value: dropdownvalue,
                
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),    
                
              // Array list of items
              items: titles.map((String items) {
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
            ),
                  //  keyboardType: TextInputType.name,), TextFormField(decoration: InputDecoration(labelText: 'State where you are licensed'),
                  //  keyboardType: TextInputType.name,), TextFormField(decoration: InputDecoration(labelText: 'license number'),
              
                   SizedBox(height: 35),
                   new ElevatedButton( style: ElevatedButton.styleFrom(fixedSize: Size(420, 35),shape:
                            RoundedRectangleBorder(
                               borderRadius : BorderRadius.circular(10),
                               side:BorderSide(color: Colors.blue),
                            
                      )),onPressed: (){
                        UserRepository user = UserRepository();
                        final new_user = user.signup(
          username: username.text,
          password: password.text,
          title: dropdownvalue,
          country: _dropdownValue.country!,
          phone: _dropdownValue.countryCode! + phoneController.text,
          email:email.text
        );
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginSignUp(userRepository: UserRepository(),)),
  );        

        
        
                      }, 
             child: new Text("Confirm"),)]
                   )
                   )
      
      ],
      ),
      )
      )
      
    );
  }
  Widget _buildCountry() {

return FormField(
  builder: (FormFieldState state) {
    return DropdownButtonHideUnderline(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new InputDecorator(
            decoration: InputDecoration(
              filled: false,
              hintText: 'Choose Country',
              prefixIcon: Icon(Icons.location_on),
              labelText:
                  _dropdownValue == null ? 'Where are you from' : 'From',
              
            ),
            isEmpty: _dropdownValue == null,
            child: new DropdownButton<CountryModel>(
              value: _dropdownValue,
              isDense: true,
              onChanged: (CountryModel? newValue) {
                print('value change');
                print(newValue);
                setState(() {
                  _dropdownValue = newValue!;
                  phoneController.text = _dropdownValue.countryCode!;
                });
              },
              items: _dropdownItems.map((CountryModel value) {
                return DropdownMenuItem<CountryModel>(
                  value: value,
                  child: Text(value.country!),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  },
);
  }
  Widget _buildPhonefiled() {
return Row(
  children: <Widget>[
    new Expanded(
      child: new TextFormField(
        controller: phoneController,
        enabled: false,
        decoration: InputDecoration(
          filled: false,
          prefixIcon: Icon(CupertinoIcons.globe),
          labelText: 'code',
          hintText: "Country code",
        ),
      ),
      flex: 2,
    ),
    new SizedBox(
      width: 10.0,
    ),
    new Expanded(
      child: new TextFormField(
       
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: false,
          labelText: 'mobile',
          hintText: "Mobile number",
          prefixIcon: new Icon(Icons.mobile_screen_share),
        ),
        onSaved: (String? value) {},
      ),
      flex: 5,
    ),
  ],
);
  } 
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      
      _dropdownItems.add(CountryModel(country: 'Afghanistan', countryCode: '+93'));
      _dropdownItems.add(CountryModel(country: 'Albania', countryCode: '+355'));
      _dropdownItems.add(CountryModel(country: 'Algeria', countryCode: '+213'));
      _dropdownItems.add(CountryModel(country: 'Argentina', countryCode: '+54'));
      _dropdownItems.add(CountryModel(country: 'Australia', countryCode: '+61'));
      _dropdownItems.add(CountryModel(country: 'Australia', countryCode: '+61'));
      _dropdownItems.add(CountryModel(country: 'India', countryCode: '+91'));
      _dropdownItems.add(CountryModel(country: 'Tunisia', countryCode: '+216'));
      _dropdownItems.add(CountryModel(country: 'Turkey', countryCode: '+90'));
      _dropdownItems.add(CountryModel(country: 'Turkmenistan', countryCode: '+993'));
      _dropdownItems.add(CountryModel(country: 'Ukraine', countryCode: '+380'));
      _dropdownItems.add(CountryModel(country: 'Uganda', countryCode: '+256'));
      _dropdownItems.add(CountryModel(country: 'United Arab Emirates', countryCode: '+971'));
      _dropdownItems.add(CountryModel(country: 'Uruguay', countryCode: '+598'));
      _dropdownItems.add(CountryModel(country: 'USA', countryCode: '+1'));
      _dropdownValue = _dropdownItems[0];
      phoneController.text = _dropdownValue.countryCode!;
      _errorText = '';
    });
  }
}

//Include Gender, TO-DO
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(suffixIcon: Icon(Icons.arrow_drop_down, size: 30),labelText: "Gender"),
      value: dropdownValue,
      style: const TextStyle(color: Colors.deepPurple),
      isExpanded: true,
      icon: Visibility(visible: false, child: Icon(Icons.pin_drop)),
      // underline: Container(
      //   height: 2,
        
      //   color: Colors.deepPurpleAccent,
      // ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['', 'Male', 'Female', 'Prefer not to say']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  
  }
  
}
