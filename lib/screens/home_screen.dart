import 'package:covid19app/helper/date_helper.dart';
import 'package:covid19app/model/date.dart';
import 'package:covid19app/model/graph_data.dart';
import 'package:covid19app/screens/country_screen.dart';
import 'package:covid19app/screens/ranking_screen.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:covid19app/components/rounded_box.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:covid19app/helper/constants.dart';
import 'package:covid19app/components/statistic_box.dart';
import 'package:covid19app/helper/network_helper.dart';
import 'package:covid19app/helper/global_data.dart';
import 'package:covid19app/model/virus.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:covid19app/components/test_box.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:covid19app/components/date_box.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart';
import 'package:covid19app/screens/ranking_screen.dart';


int currentSelectedIndex;

final pageController = PageController(
  initialPage: 0,
);

CountryPicker countryPicker;
Country country = Country.fromJson(countryCodes[0]);


class HomeScreen extends StatefulWidget {

//  final String title;
  VirusData virusData;
  GraphData graphData;
  HomeScreen({this.virusData, this.graphData});

//  HomeScreen({this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


//  List<RoundedBox> roundBoxes = [];
  int currentIndex;
  final List<Widget> _children = [
    RankingScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;

    countryPicker = CountryPicker(onCountrySelected: (Country country) {
      print(country.flagUri);
      GlobalData.selectedCountryName = country.name;
//      GlobalData.selectedCountryFlagUrl = country.flagUri;

//      if( country.name == kWorldWide ) {
        GlobalData.selectedDate = GlobalData.dateHelper.getTodayDate();
        pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 1),
          curve: Curves.easeIn,
        );
//      }

      retrieveData(GlobalData.selectedDate, country.name);
    });
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
      print(currentIndex);
    });
  }

  String checkEmpty(String str) {

    if( str == '' || str == '+') {
      return '0';
    } else {
      return str;
    }
  }

  List _buildList() {
    List<Widget> listItems = List();
    List<String> titleArray = ['Total Cases', 'Total Deaths', 'Total Recovered', 'New Cases', 'New Deaths'];
    List<String> imgArray = ['assets/infected.png', 'assets/death.png', 'assets/recover.png', 'assets/new.png', 'assets/newDeath.png'];
    List<Color> colorArray = [kMainCOlor, Colors.red, Colors.lightGreen, Colors.white,Colors.white];
    List<Color> textColorArray = [kMainCOlor, Colors.red, Colors.lightGreen, kMainCOlor, Colors.red];

    List<List<double>> dataArray = [];
    if( widget.graphData != null ) {
      dataArray.add(widget.graphData.cases);
      dataArray.add(widget.graphData.deaths);
      dataArray.add(widget.graphData.recovered);
      dataArray.add([0.0]);
      dataArray.add([0.0]);
    } else {
      dataArray.add([0.0]);
      dataArray.add([0.0]);
      dataArray.add([0.0]);
      dataArray.add([0.0]);
      dataArray.add([0.0]);
    }

    int idx = 0;
    widget.virusData.data.forEach((k, v) {

      if( idx != 5 ) {
        listItems.add(StatisticBox(
          imgUrl: imgArray[idx],
          title: titleArray[idx],
          stats: checkEmpty(v),
          data: dataArray[idx],
          graphColor: colorArray[idx],
          textColor: textColorArray[idx],
        ));
      }

      idx++;
    });
//    widget.virusData.data.forEach((k,v) => print('${k}: ${v}'));
//    widget.virusData.da;

//    for (var data in widget.virusData.date) {
//      listItems.add(StatisticBox(
//        imgUrl: widget.virusData.data[],
//        title: 'aa',
//        stats: 'asd',
//
//      ));
//    }

    return listItems;
  }

  void updateUI(VirusData data, GraphData graphData) {
    setState(() {
      widget.virusData = data;
      widget.graphData = graphData;
    });
  }

  void retrieveGraphData(String country) {
    var future = GlobalData.networkHelper.getGraphStats(country);
    future.then((GraphData value) {
      widget.graphData = value;
      updateUI(widget.virusData,widget.graphData);
//    print(value);
    },onError: (e) {
      print(e);
      Alert(context: context, title: "Unavailable", desc: "Graph data is not available.").show();
    });
  }

  void retrieveLocationData(Future<String> country) {

    var future = country;
    future.then((String value) {
      if( value == '' ) {
        Alert(context: context, title: "Unavailable", desc: "Location is disabled or unavailable").show();
      } else {
        GlobalData.selectedDate = GlobalData.dateHelper.getTodayDate();

        if( value == "United States" ) {
          retrieveData(GlobalData.selectedDate, "USA");
        } else if ( value == "United Kingdom" ) {
          retrieveData(GlobalData.selectedDate, "UK");
        } else {
          retrieveData(GlobalData.selectedDate, value);
        }
      }

    },onError: (e) {
      print(e);
      Alert(context: context, title: "Unavailable", desc: "Location data is not available.").show();
    });
  }

  void retrieveData(DateModel d, String country) {

    print(country);
    //temporary store prev country in case country not found
    String prevCountryName = GlobalData.selectedCountryName;

    if(country == kWorldWide) {
      var future = GlobalData.networkHelper.getWorldStats();
      future.then((VirusData value) {
        widget.virusData = value;
        GlobalData.selectedCountryName = widget.virusData.country;
        retrieveGraphData(kWorldWide);
      },onError: (e) {
        print(e);
        Alert(context: context, title: "Unavailable", desc: "Data is not available.").show();
        GlobalData.selectedCountryName = prevCountryName;
      });
    } else {

      var future = GlobalData.networkHelper.getLatestStatsByCountry(country, d.id);
      future.then((VirusData value) {
        widget.virusData = value;
        GlobalData.selectedCountryName = widget.virusData.country;
//        print('aaaa ${widget.virusData.country}');
//        print('bbbb $country');
//        print(value.country);
        retrieveGraphData(country);
      },onError: (e) {
        print(e);

        Alert(context: context, title: "Unavailable", desc: "Data is not available.").show();
        GlobalData.selectedCountryName = prevCountryName;
      });
    }

  }

  void test(int idx, List<RoundedBox> box) {


    int i = 0;
    for( RoundedBox b in box ) {

      if( i == idx ) {
//        b.isSelected = true;
      } else {
//        b.isSelected = false;
      }

      i++;
    }

    setState(() {

    });

  }

  List<RoundedBox> updateDatesUI(DateModel d) {
//
//    setState(() {
//      print(currentSelectedIndex);
//    });

    GlobalData.selectedDate = d;
    retrieveData(d,GlobalData.selectedCountryName);
//    List<RoundedBox> boxes = [];
//
//    Map<String,RoundedBox> mapBoxes = new Map<String,RoundedBox>();
//
//    bool isSelected = false;
//
//    for( int i = 0; i < GlobalData.dateHelper.dates.length; i ++) {
//
//      var d = GlobalData.dateHelper.dates[i];
//
//      var box = RoundedBox(day: d.day,date: '${d.date} ${d.month}',callBackOnPress: (){
//        GlobalData.selectedDate = d;
//        retrieveData(GlobalData.selectedDate,GlobalData.selectedCountryName);
////        test(i, boxes);
//      });
//
//      boxes.add(box);
//    }

//    for( DateModel d in GlobalData.dateHelper.dates ) {
//
//      var box = RoundedBox(day: d.day,date: '${d.date} ${d.month}',onPress: (){
//        GlobalData.selectedDate = d;
//        retrieveData(GlobalData.selectedDate,GlobalData.selectedCountryName);
//
//      }, isSelected: isSelected,);
//
//      boxes.add(box);
//    }

//    return boxes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainCOlor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(backgroundColor: kMainCOlor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: kMainCOlor,
        onPressed: () {
            pageController.jumpToPage(0);
          retrieveLocationData(GlobalData.locationHelper.getLocation());
        },
        child: Icon(Icons.my_location),
),
//        bottomNavigationBar: BubbleBottomBar(
//          backgroundColor: Colors.white,
//          opacity: .2,
//          currentIndex: currentIndex,
//          onTap: changePage,
//          borderRadius: BorderRadius.vertical(
//              top: Radius.circular(
//                  20)),
//          //border radius doesn't work when the notch is enabled.
//          elevation: 10,
//          items: <BubbleBottomBarItem>[
//            BubbleBottomBarItem(
//                backgroundColor: Colors.red,
//                icon: Icon(
//                  Icons.dashboard,
//                  color: Colors.black,
//                ),
//                activeIcon: Icon(
//                  Icons.dashboard,
//                  color: Colors.red,
//                ),
//                title: Text("Home")),
//            BubbleBottomBarItem(
//                backgroundColor: Colors.deepPurple,
//                icon: Icon(
//                  Icons.access_time,
//                  color: Colors.black,
//                ),
//                activeIcon: Icon(
//                  Icons.access_time,
//                  color: Colors.deepPurple,
//                ),
//                title: Text("Logs")),
//            BubbleBottomBarItem(
//                backgroundColor: Colors.indigo,
//                icon: Icon(
//                  Icons.folder_open,
//                  color: Colors.black,
//                ),
//                activeIcon: Icon(
//                  Icons.folder_open,
//                  color: Colors.indigo,
//                ),
//                title: Text("Folders")),
//            BubbleBottomBarItem(
//                backgroundColor: Colors.green,
//                icon: Icon(
//                  Icons.menu,
//                  color: Colors.black,
//                ),
//                activeIcon: Icon(
//                  Icons.menu,
//                  color: Colors.green,
//                ),
//                title: Text("Menu"))
//          ],
//        ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: CustomSliverDelegate(
                    expandedHeight: 200,
                    callBackGetCountryData: retrieveData,
                    callBackUpdateSelectedDateUI: updateDatesUI
                ),
              ),
//              SliverFillRemaining(
//              ),
              Container(
                child: SliverList(
                  delegate: new SliverChildListDelegate(_buildList()),
                )
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  height: 50,
                  color: Colors.transparent,
                  child: Center(
                    child: Text('Last Updated: ${widget.virusData.recordedTime}',
                      textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8)
                    ),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;

  final Function callBackGetCountryData;
  final Function callBackUpdateSelectedDateUI;
//  String selectedCountryName = GlobalData.selectedCountryName;
//  DateModel selectedDate = GlobalData.selectedDate;



  VirusData virusData;


  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
    @required this.callBackGetCountryData,
    @required this.callBackUpdateSelectedDateUI
  });

  @override
  Widget build(

      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight + 40,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kMainCOlor,
              elevation: 50,
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    countryPicker.launch(context);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                          AssetImage(GlobalData.selectedCountryFlagUrl, package: 'ola_like_country_picker'),
                        ),
                      )
                  ),
                ),
                new IconButton(
                  icon: new Image.asset('assets/worldwide.png'),
                  onPressed: (){
                    countryPicker.launch(context);
                  },
                ),
              ],
              title: Opacity(
                  opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                  child: Column(
                    children: <Widget>[
                      Text(GlobalData.selectedCountryName),
                    ],
                  )
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 40,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:10.0),
                child: Container(
                  height: 20,
                  child: Text(GlobalData.selectedCountryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition + (cardTopPosition * 0.2): 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  elevation: 20.0,
                  child: Center(
                    child: PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      physics: GlobalData.selectedCountryName == kWorldWide ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
                      itemCount: GlobalData.dateHelper.dates.length,
                      onPageChanged: (int idx) {
                        callBackUpdateSelectedDateUI(GlobalData.dateHelper.dates[idx]);
                      },
                      itemBuilder: (context, index) {
                        return DateBox(day: GlobalData.dateHelper.dates[index].day, date: '${GlobalData.dateHelper.dates[index].date} ${GlobalData.dateHelper.dates[index].month}',);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
