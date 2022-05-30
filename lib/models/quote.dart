class Quote{
  final String qid;
  final String text;
  final String q_class;


  Quote({
    required this.qid,required this.text,required this.q_class,});




    @override
  List<Object> get props => [
        qid,
        text,
        q_class,
        
      ];
  // factory Quote.fromJson(Map<String, dynamic> json) {
   
  //   return Quote(
  //     qid: json['qid'],
  //     text: json['text'],
  //     q_class: json['q_class'],
      
  //   );
  // }
  factory Quote.fromMap(Map<String, dynamic> map) {
    // print(map);
    // print(map['qid']);
    // print(map['text']);
    // print(map['q_class'].toString());
    // Quote(q_class: map['q_class'].toString(), text:map['text'], qid:map['qid']);
    print("hi");
    return Quote(
      qid: map['qid'].toString() ,
      text: map['text'].toString(),
      q_class:map['q_class'].toString());
      }
        
      
    

  // Map<String, dynamic> toJson() => {
  //   'qid' : qid,
  //   'text': text,
  //   'q_class': q_class,
    
  // };
}