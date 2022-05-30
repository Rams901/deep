import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:deeptherapy/models/api_model.dart';
import '../models/quote.dart';


final _base = "https://cryptic-depths-14871.herokuapp.com";
final _tokenEndpoint = "/api-token-auth/";
final docEndpoint = "/api/add_doctor/";
final _tokenURL = _base + _tokenEndpoint;
final _addDocURL = _base + docEndpoint;
final _genCode = _base + "/api/generate_code";
//For doctor

//the login page, once submitted username/password, the event loginbuttonpressed is triggered which awaits username, password and send it
// to userrepository.authenticate which is a future function that once found username, password will grab the Userlogin
// class, initiating an object with username & password given, sends the object to getToken Future function, wich will
// send it as post to the given URL, with the required thingies in body as JSON. LOVELY!
// the signup page? once submitted the information needed for doctor (title, username, password, country, phone, )
// triggers login block
// sends it to userrepo.create which is a future function that once found will grab the UserSignup class and
// send it as post to the given URL (api/add_doctor/) and return to the login page if Response is 200.
//it's recommended to just call whatever in the SignupButton inside the signup page to prevent so many errors.
Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson("yes")),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body).toString());
    return Token.fromJson(json.decode(response.body));
  } 
  else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<int> SignUp(DocSignUp doc) async {
  print(_addDocURL);
  final http.Response response = await http.post(
    _addDocURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(doc.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body).toString());
    return response.statusCode;
  } 
  else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

// class QuoteProvider with ChangeNotifier {
//   QuoteProvider(){
//     this.fetchTasks();
//     }
//     List<Quote> _quote = [];
//     List <Quote> get quote {
//     return [..._quote];
//     } 
//     fetchTasks() async {
//     final url = _base + 'api/quote';
//     final response = await http.get(Uri.parse(url), headers: {'Authorization': 'TOKEN 34a186a18be1404bbe3283d4d6eb909b2cdefc52'});
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body) as List;
//       print(data);
//       _quote = data.map<Quote>((json) => Quote.fromJson(json)).toList();
//     }
//     notifyListeners();
//   }
// }
Future<Token> genCode(UserLogin userLogin) async {
  print(_genCode);
  final http.Response response = await http.post(
    _genCode,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson("yes")),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body).toString());
    return Token.fromJson(json.decode(response.body));
  } 
  else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}