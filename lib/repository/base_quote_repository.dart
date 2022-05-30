import '../models/quote.dart';
abstract class BaseQuoteRepository {
  Future<List<Quote>> getQuotes({
    int quota,
    
    String q_class,
  });
}
