import 'package:covid19app/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:covid19app/screens/tip_details_screen.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
//import 'package:app_review/app_review.dart';
import 'package:flutter_share/flutter_share.dart';
//import 'package:native_share/native_share.dart';

class SettingScreen extends StatefulWidget {

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<String> details = ['FAQ','Where do we obtain our data?','How often do we update our stats?','Support','Leave a Rating', 'Report a Bug', 'Report Inaccurate Stats', 'Share Us'];

  List<IconData> icons = [Icons.print, Icons.data_usage, Icons.update, Icons.print, Icons.rate_review, Icons.bug_report, Icons.report_problem, Icons.share];

  List<String> tagArray = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Hey there, I am using this app to check the COVID-19\'s statistic!',
        text: 'Hey there, I am using this app to check the COVID-19\'s statistic!',
        linkUrl: 'https://apps.apple.com/sg/app/heywork-service-marketplace/id1505927620',
        chooserTitle: 'Hey there, I am using this app to check the COVID-19\'s statistic!'
    );
  }

  void tapTile(int i) {
    List<String> faqDetails = ['', 'We are working hard to keep you updated on COVID-19. The data displayed is collected from John Hopkins Hospital and WHO.', 'We update our data every day. We do not report presumptive cases hence sometime our data will be delayed.\n\nWe are totally aware that cases are reported by local news agencies faster than JHH reports cases. As a responsible person, we will keep our users updated on the latest cases by only reporting the confirmed cases.', '', ''];

    List<IconData> iconArray = [Icons.print,Icons.data_usage, Icons.update];

    if( i == 1 || i == 2 ) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return TipDetailScreen(imgUrl: '', heroTag: tagArray[i],detail: faqDetails[i],title: details[i],iconData: iconArray[i]);
      }));
    } else {

      if( i == 4 ) {
        LaunchReview.launch(androidAppId: "",
            iOSAppId: "1505927620");

//        if (Platform.isIOS) {
//          AppReview.requestReview.then((onValue) {
//            print(onValue);
//          });
//        }
      }

      if( i == 5 ) {
        _launchURL('mailto:info@xaviertanxy.com?subject=Reporting%20of%20Bugs&body=');
      }

      if( i == 6 ) {
        _launchURL('mailto:info@xaviertanxy.com?subject=Reporting%20of%20Inaccurate%20of%20Stats&body=');
      }

      if( i == details.length - 1) {
        share();
//        NativeShare.share({'title':'Hey there, I am using this app to check the COVID-19\'s statistic!','url':'https://apps.apple.com/sg/app/heywork-service-marketplace/id1467610312','image':'mask.png'});
      }
    }

  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: kMainCOlor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Color(0xffF9FAFB),
          child: ListView.builder(
            itemCount: details.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0 || index == 3) {
                // return the header
                return new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 20,
//                  width: 110,
//                    color: Colors.black,
                      child: Text(details[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),),
                    )
                  ],
                );
              }
              // return row
              return ListTile(
                leading: Hero(
                  tag: tagArray[index],
                  child: Icon(
                    icons[index],
                  ),
                ),
                title: Text(details[index]),
                onTap: () {
                  tapTile(index);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
