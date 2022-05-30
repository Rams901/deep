import 'dart:math';
import 'dart:ui';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import '../../repository/quote_repository.dart';
import '../../models/quote.dart';
import 'package:deeptherapy/constants.dart';
import '../../models/failure_model.dart';
import 'package:deeptherapy/Patient/widgets/bottom_nav_bar.dart';
// import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
// import 'package:table_calendar/table_calendar.dart';
import '../widgets/calendar.dart';
import '../widgets/utils.dart';
class QuoteApp extends StatefulHookWidget {
  @override
  _QuoteAppState createState() => _QuoteAppState();
}
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}
//Notes:
//1- History for quotes last 1 year.
//2- Scroll to previous days (quotes) or click on day.
//3- Generate list items to be fixed
//4- Recommendation System: We have a database (quote/label), we predict the quotes correlated to the patient's label.  
//5- We save the index of quotes joined the date (starting from using the app), one quote / day will be revealed accessing previous quotes.
//6- first five days will have general quotes
//7- database(quote, date, shown (bool)) 

// CASE CLOSED CHANGE TO TABLE CALENDAR AND WORK FROM SCRATCH THERE.
//started again with reformulated design. It's better
//what is left:
//starting at the last quote with datetime now and can only go back from or go scroll right till datetime now.
//creating the backend model, can get inspired from quiz app.


//LEFT TO DO, change the colors. Wait for patient to have class to change the variable + start day.
typedef CalendarCallback = void Function(DateTime date);

 final quotesProvider = FutureProvider.autoDispose<List<Quote>>(
    (ref) => ref.watch(quoteRepositoryProvider).getQuotes(
          quota: 10, //change to datetime.now() - start_day (access from profile)
          q_class: "Depression", //Change to user class.
        //category value + remove difficulty
        ),
  );
class _QuoteAppState extends State<QuoteApp> {
    
final months = ["Jan","Feb","Mars", "April", "May", "June", "July", "August","Sep", "Oct", "Nov", "Dec"];
Random random = new Random();
int index = 0;
int col_index = 0;
  void changeIndex() {
    setState(() => col_index = random.nextInt(3));
  }

int initial_index = 0;
final ScrollController controller = ScrollController();
Color testc = Colors.black;

  // final _list = Quote.generateQuoteBlog();
  final _pageCtrl = PageController(viewportFraction: 0.9);

  DateTime? selectedDay = DateTime.now();
  List? selectedEvent;
  

  Color generate_background_color( index){
    
    print(index);
   
    List colors = [
      Color(0xFFFFF1E4),
      Color(0xFFFFDAB9),
      Color(0xFF68A3FF),
      Color(0xFF002366),
      Color(0xFF0F52BA),
     ];
    return colors[index%5];
  }
  Color generate_text_color(index){
    List colors = [Color(0xFF979797),
    Color(0xFF979797),
    Colors.white,Colors.white,Colors.white, Colors.white
    ];
    return colors[index%5];
  }
  void _handleData(date){
    setState(() {
      selectedDay = date;
      print(selectedEvent);
    });
    print(selectedDay);
  }

  @override
  void initState() {
    // TODO: implement initState
     
    //selectedEvent = events[selectedDay] ?? [];
    
    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
      final quotes = useProvider(quotesProvider);
      DateTime _focusedDay = DateTime.now();
      DateTime? _selectedDay;
 
      
      
    return Scaffold(
     bottomNavigationBar: BottomNavBar(),

      appBar: AppBar(
           backgroundColor: Colors.white,elevation: 0,
           title: 
           
            Text("Quote Space", style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w700),
           ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back,size:35,color:kBlueLight,), onPressed: () {  },),
          actions: <Widget>[
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: CircleAvatar(backgroundColor: Colors.white,
    radius: 35.0,
    child: ClipRRect(
      
          child: Image.asset("lib/assets/images/user.png"),
          borderRadius: BorderRadius.circular(30.0),
   )),
           ),
          ],
          

    ), 
      body: quotes.when(data:(quotes_grabbed,)=> _buildBody(context, quotes_grabbed),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => QuoteError(message: error is Failure ? error.message : 'Something went wrong!',
          ),
          ),
          );}

Widget _buildBody( BuildContext context,
    List<Quote> quotes,)
    {
          return SafeArea( 
       child: 
       Padding(
         padding: const EdgeInsets.all(15.0),
         child: 
           

           Container(child: ScrollConfiguration(
  behavior: MyCustomScrollBehavior(),
  
  child: Stack(children: [PageView.builder(scrollDirection: Axis.horizontal,
      controller: _pageCtrl,
      reverse:true,
      onPageChanged: (int x ){print(x);
      // TRY TO ACCESS THE VARIABLES COLORS WHEN BUILDING. THE COLOR CHANGE BUT THE TAPPING IS STILL NOT HAPPENING. builder is not activated. 
      //(int ) { print(selectedDay);
        print(index);
        print(selectedDay);
        setState((){
        // selectedDay.value = selectedDay.value.add(Duration(days: 1));
        
        if((x - index) <0) selectedDay = selectedDay?.add(Duration(days: 1));
        if((x - index) > 0) selectedDay = selectedDay?.subtract(Duration(days:1));
        
        index = x;
        
        print(selectedDay);
        // yo.onDaySelected!(_selectedDay!, _focusedDay);

        //           _handleData(selectedDay!.add(Duration(days: 1)));
        //         };
       
      //   print(selectedDay);
        
      });}
        /// TO DO, SELECT THE DAY ACCORDING TO THE PAGEEEEEEE.
        /// UNEXPECTED NULL VALUE FOR THE DAY BUILDER/ CHANGING THE SELECTED DAYS ARE STRONGLY CORRELATED TO THE HANDLE SELECTED DATE AND USER CALLBACK
      ,
      itemCount: quotes.length,
      itemBuilder: (context,index){
        return  Container(
              
               
               
         color:generate_background_color(index),
       
         
          child: Column(
      
              children: [
              Material(
                color:Colors.transparent,
                child:
                Padding(
                  padding: const EdgeInsets.only(right:170,top:25),
                  child: Text(months[selectedDay!.month-1]+ " " + selectedDay!.day.toString() + "\n" + selectedDay!.year.toString(),
                  style:TextStyle(
                    color:generate_text_color(index),fontWeight: FontWeight.w600,
                    fontSize: 15)),
                )),
                
              
              
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 50),
                     child: Material(
                color:Colors.transparent,
                
                  child: Container(child: Text(quotes[index].text,textAlign:TextAlign.center,
                  style:
                  TextStyle(color:generate_text_color(index),fontWeight:FontWeight.bold,fontSize: 20)
                      ),
                  )
                  ),
                   ),
  
                 Material(
                   color: Colors.transparent,
                 child: IconButton(
            icon:  Icon(Icons.favorite_border),
            color: generate_text_color(index),iconSize: 35,
            onPressed: () {},
          ),
          ),       
          ],
          )
        ,
             );
      }),Align(alignment: AlignmentDirectional.centerStart,child:Icon(Icons.arrow_back_ios)),Align(alignment: AlignmentDirectional.centerEnd,child:Icon(Icons.arrow_forward_ios))]
      )
      )
       ))
      );}
      
      
           
         
         
      
         
}

class QuoteError extends StatelessWidget {
  final String? message;

  const QuoteError({
    Key? key,
    @required this.message,
  }) : super(key: key);@override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 20.0),
          CustomButton(
            title: 'Retry',
            onTap: () => context.refresh(quoteRepositoryProvider),
          ),
        ],
      ),
    );
  }
}
//Problem is in the api function, there was throw error here.
class CustomButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;

  const CustomButton({
    Key? key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20.0),
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.yellow[700],
         
          borderRadius: BorderRadius.circular(25.0),
        ),
        alignment: Alignment.center,
        child: Text(
          title!,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}