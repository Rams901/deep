import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:enum_to_string/enum_to_string.dart';
import 'base_quote_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meta/meta.dart';
import '../models/quote.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/failure_model.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final quoteRepositoryProvider =
    Provider<QuoteRepository>((ref) => QuoteRepository(ref.read));

class QuoteRepository extends BaseQuoteRepository {
  final Reader _read;

  QuoteRepository(this._read);

  @override
  Future<List<Quote>> getQuotes({
    @required int? quota,
    @required String? q_class,
    
  }) async {
    try {

      final query_parameters = {'Q_Class': q_class,
              'Quota': quota.toString(),};
      final headers = {
        "Authorization": 'TOKEN 1f1bf307ae51363faa8338bc7c887aa5af96337a', //to be changed to auth_token for user
       'Q_Class':"Depression","Quota":"10",
        "Access-Control-Allow-Origin": "*",
      };
      
    String url = "https://cryptic-depths-14871.herokuapp.com/api/quote/";
    print("HELLO");
    final response = await _read(dioProvider).get(url,options:Options(method: 'GET', headers: headers));
    
    // await http.get(Uri.parse(url),headers: headers);
    print("hi");
      // final response = await _read(dioProvider).get(
      //   'https://opentdb.com/api.php',
      //   queryParameters: queryParameters,
      // );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
      print("WE MADE IT");
      // var data = Map<String, dynamic>.from(response.data);
      
      print("hi");
      
        // data['results'] add answers from here initialized
      
        final results = List<Map<String, dynamic>>.from(response.data);
        print(results);
        // print(results.map((e) => Quote.fromJson(e)).toList());
        if (results.isNotEmpty) {
          print("MAN ITS ALL GOOD");
          var hi = results.map((e) => Quote.fromMap(e));
          print(hi);
          print("y");
          return results.map((e) => Quote.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err) {
      print(err);
      print('WHAT??');
      throw Failure(
        message: err.response?.statusMessage ?? 'Something went wrong!',
      );
    } on SocketException catch (err) {
      print(err);
      throw const Failure(message: 'Please check your connection.');
    }
  }
}
