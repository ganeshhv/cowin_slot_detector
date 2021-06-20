import 'dart:async';

import 'package:cowin_slot_detector/bloc/slotbypin/oneweek_slotby_pin_bloc.dart';
import 'package:cowin_slot_detector/bloc/slotbypin/oneweek_slotby_pin_event.dart';
import 'package:cowin_slot_detector/bloc/slotbypin/oneweek_slotby_pin_state.dart';
import 'package:cowin_slot_detector/models/base/drawer_left.dart';
import 'package:cowin_slot_detector/models/slotbypin/child_sessions_list_response.dart';
import 'package:cowin_slot_detector/models/slotbypin/oneweek_slot_by_pin_response.dart';
import 'package:cowin_slot_detector/repository/api_client.dart';
import 'package:cowin_slot_detector/repository/slotbypin_repository.dart';
import 'package:cowin_slot_detector/utils/app_config.dart';
import 'package:cowin_slot_detector/utils/app_contanst.dart';
import 'package:cowin_slot_detector/utils/banner_image.dart';
import 'package:cowin_slot_detector/utils/styles/main_theme.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class SlotByPinPage extends StatefulWidget {
  @override
  _SlotByPinPageState createState() => _SlotByPinPageState();
}

class _SlotByPinPageState extends State<SlotByPinPage> with SingleTickerProviderStateMixin {
   final _searchController = TextEditingController();
   OneweekSlotByPinResponse slotByPinResponse;
   List<ChildSessionsListResponse> sessionsListResponse;
   bool isProcessingSlot = false;
   DateTime currentDate;
  var formatedStartDate;
  int slotIndex;


  // for internet Connection
  StreamSubscription<DataConnectionStatus> listener;
  var InternetStatus = "Unknown";
  var contentmessage = "Unknown";
  bool isConnected;
  DataConnectionStatus status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDate = DateTime.now();
    print(currentDate);

  }

  callOneWeekSlotApi(BuildContext context, String text) async
  {
    status = await checkConnection(context);
    formatedStartDate =
    DateFormat(AppConstant().defaultDateTimeFormat).format(currentDate);
    if (status == DataConnectionStatus.connected)
    {
      isProcessingSlot = true;
      print('BlocProvider result: callOneweekSlotApi');
      BlocProvider.of<OneWeekSlotBloc>(context).add(
          GetOneweekSlotApi(
              date: formatedStartDate,
              pincode: text)
      );
    }
    else
    {
      _showConnectionDialog(context);
    }
  }

  final SlotByPinRepository pinRepository = SlotByPinRepository(
      apiClient: ApiClient(httpClient: http.Client())
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of Slots'),),
      drawer: DrawerLeft(),
      body: BlocProvider(
        create: (context) => OneWeekSlotBloc(repository: pinRepository),
        child: BlocBuilder<OneWeekSlotBloc, OneWeekSlotState>(
          builder: (context, state) {
            if (state is GetOneWeekSlotInit)
              {
                print('GetOneWeek Slot Init');
                return searchByPinView(context, state);

              }
            if (state is GetOneWeekSlotLoading)
              {
                print('GetOneWeek Slot loading');
                return Center(
                  child: loadingView(),
                );
              }
            if (state is GetOneWeekSlotSuccess)
              {
                if(isProcessingSlot)
                  {
                    print('GetOneWeekSlot Success');
                    isProcessingSlot = false;
                    slotByPinResponse = state.response;
                    // sessionsListResponse.clear();
                    if(slotByPinResponse.centers != null)
                      {
                        slotByPinResponse.centers.forEach((element)
                        {
                          element.sessions.map((e) {
                            print('${e.date} --> ${formatedStartDate}');
                            print(e.date.contains(DateFormat('dd-MM-yyy').format(currentDate)));
                            if(e.date.contains(DateFormat('dd-MM-yyy').format(currentDate)))
                            {
                              slotIndex = e.date.indexOf(DateFormat('dd-MM-yyy').format(currentDate));
                              print('slotIndex:$slotIndex');
                            }
                          }).toList();
                        });
                      }
                  }
              }
            if (state is GetOneWeekSlotError)
              {
                if(isProcessingSlot)
                {
                  print('GetOneWeekSlot Error');
                  isProcessingSlot = false;
                }
              }
            return searchByPinView(context, null);
          },
        ),
      ),
    );
  }

  Widget loadingView() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SizedBox(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 1,
        ),
        height: 20.0,
        width: 20.0,
      ),
    );
  }

  searchByPinView(BuildContext context, OneWeekSlotState state)
  {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Pin',
                        suffixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.fromLTRB(8 , 5, 8, 5)
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5),
                        bottom: BorderSide(color: Colors.grey, width: 0.5),
                        left: BorderSide(color: Colors.grey, width: 0.5),
                        right: BorderSide(color: Colors.grey, width: 0.5),

                      )
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if(_searchController.text.isNotEmpty)
                      {
                        setState(() {
                          callOneWeekSlotApi(context, _searchController.text);
                        });
                      }
                    else _showToast('Please enter the pincode');
                  },
                  child: Text('Search', style: TextStyle(color: Colors.white),),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.shade400
                ),
              ),
            ],
          ),
          (state is GetOneWeekSlotInit) ? Container() : Expanded(
            child: listofCenters(),
          )


        ],
      ),
    );
  }


  searchByMapView(BuildContext context)
  {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Pin',
                          suffixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.fromLTRB(8 , 5, 8, 5)
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.5),
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                          left: BorderSide(color: Colors.grey, width: 0.5),
                          right: BorderSide(color: Colors.grey, width: 0.5),

                        )
                    ),
                  ),
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }

  listofCenters()
  {
    return ListView.builder(
      itemCount: slotByPinResponse.centers.length,
      itemBuilder: (context,int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(5),
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(slotByPinResponse.centers[index].name,style: MainTextStyle.defaultStyle3,)),
                      Text(slotByPinResponse.centers[index].address, style: MainTextStyle.defaultStyle2,),
                    ],

                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        vaccineCapacity(index),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(slotByPinResponse.centers[index].sessions[slotIndex].vaccine),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        margin: EdgeInsets.only(bottom: 1),
                        child: Text('Age +${slotByPinResponse.centers[index].sessions[slotIndex].minAgeLimit}', style: TextStyle(color: Colors.white),),
                        decoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            borderRadius: BorderRadius.all(Radius.circular(2))
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 1),
                        padding: const EdgeInsets.all(3.0),
                        child: Text(slotByPinResponse.centers[index].feesType, style: TextStyle(color: Colors.white),),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(2))
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },

    );
  }


  vaccineCapacity(int index)
  {
    return (slotByPinResponse.centers[index].sessions[slotIndex].availableCapacity != 0) ?
    Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 35,
            child: Text('D1\n${slotByPinResponse.centers[index].sessions[slotIndex].availableCapacityDose1}',  textAlign: TextAlign.center,),
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey)
            ),
          ),
          Container(
            width: 35,
            height: 35,
            child: Align(alignment: Alignment.center,child: Text('${slotByPinResponse.centers[index].sessions[slotIndex].availableCapacity}', style: TextStyle(fontFamily: 'RobotoBold',),)),
            decoration: BoxDecoration(
                color: Colors.greenAccent.shade400,
                border: Border.all(width: 1.0, color: Colors.grey)
            ),
          ),
          Container(
            width: 30,
            height: 35,
            child: Text('D2\n${slotByPinResponse.centers[index].sessions[slotIndex].availableCapacityDose2}', textAlign: TextAlign.center,),
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey)
            ),
          ),
        ],
      )
    ) : Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 1),
      child: Text('Booked', style: TextStyle(color: Colors.white),),
      decoration: BoxDecoration(
          color: Colors.red.shade900,
          borderRadius: BorderRadius.all(Radius.circular(4))
      ),
    );
  }

  //check internet  connection
  checkConnection(BuildContext context) async{
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status){
        case DataConnectionStatus.connected:
          InternetStatus = "Connected to the Internet";
          contentmessage = "Connected to the Internet";
          // _showDialog(InternetStatus,contentmessage,context);
          // _showToast(InternetStatus);
          _showConnectionDialog(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => super.widget));
          isConnected = true;
          break;
        case DataConnectionStatus.disconnected:
          InternetStatus = "You are disconnected to the Internet. ";
          contentmessage = "Please check your internet connection";
          // _showDialog(InternetStatus,contentmessage,context);
          _showToast(InternetStatus);
          isConnected = false;
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }

  _showConnectionDialog(BuildContext context)
  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('No Internet'),
          content: Text('Check your Internet Connection'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                _showToast('pressed');
                Navigator.of(context).pop();// Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  _showToast(String message)
  {
    Toast.show(message,context,
      duration: Toast.LENGTH_LONG);
  }

}

