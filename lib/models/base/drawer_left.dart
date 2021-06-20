import 'package:cowin_slot_detector/pages/homepage/home_page.dart';
import 'package:cowin_slot_detector/pages/slot_by_latlong/slot_by_latlong_page.dart';
import 'package:cowin_slot_detector/pages/slot_by_pin/slot_by_pin_page.dart';
import 'package:cowin_slot_detector/utils/styles/main_theme.dart';
import 'package:flutter/material.dart';

class DrawerLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return initMenuLeft(context);
  }

  Widget initMenuLeft(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      color: MainColors.headerMenu,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('User', style: MainTextStyle.defaultStyle1,),
                      ),
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white70,
                  width: 0.3,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
                size: 23,
              ),
              title:
              Text('HomePage', style: MainTextStyle.defaultStyle1),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage()),
                );
              },
            ),
            decoration: BoxDecoration(
              color: MainColors.childMenu,
              border: Border(
                bottom: BorderSide(
                  color: Colors.white70,
                  width: 0.3,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(
                Icons.airline_seat_legroom_normal_outlined,
                color: Colors.white,
                size: 23,
              ),
              title:
              Text('Search Slot', style: MainTextStyle.defaultStyle1),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SlotByPinPage()),
                );
              },
            ),
            decoration: BoxDecoration(
              color: MainColors.childMenu,
              border: Border(
                bottom: BorderSide(
                  color: Colors.white70,
                  width: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
