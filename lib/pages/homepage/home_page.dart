import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cowin_slot_detector/bloc/publicReports/public_report_bloc.dart';
import 'package:cowin_slot_detector/bloc/publicReports/public_report_event.dart';
import 'package:cowin_slot_detector/bloc/publicReports/public_report_state.dart';
// import 'package:cowin_slot_detector/bloc/slotbypin/oneweek_slotby_pin_bloc.dart';
// import 'package:cowin_slot_detector/bloc/slotbypin/oneweek_slotby_pin_event.dart';
// import 'package:cowin_slot_detector/bloc/slotbypin/oneweek_slotby_pin_state.dart';
import 'package:cowin_slot_detector/models/base/drawer_left.dart';
import 'package:cowin_slot_detector/models/publicReports/public_reports_response.dart';
import 'package:cowin_slot_detector/models/slotbypin/oneweek_slot_by_pin_response.dart';
import 'package:cowin_slot_detector/repository/api_client.dart';
import 'package:cowin_slot_detector/repository/public_report_repository.dart';
import 'package:cowin_slot_detector/repository/slotbypin_repository.dart';
import 'package:cowin_slot_detector/utils/app_config.dart';
import 'package:cowin_slot_detector/utils/app_contanst.dart';
import 'package:cowin_slot_detector/utils/banner_image.dart';
import 'package:cowin_slot_detector/utils/styles/main_theme.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _pinController = TextEditingController();
  PublicReportsResponse publicReportsResponse;
  OneweekSlotByPinResponse pinResponse;
  bool isGetPublicReport = false;
  bool isProcessingSlot = false;
  DateTime currentdate = DateTime.now();

  // for internet Connection
  StreamSubscription<DataConnectionStatus> listener;
  var InternetStatus = "Unknown";
  var contentmessage = "Unknown";
  bool isConnected;
  DataConnectionStatus status;

  final PublicReportRepository repository = PublicReportRepository(
      apiClient: ApiClient(
        httpClient: http.Client()
      )
  );

  callPublicReportApi(BuildContext context) async
  {
    status = await checkConnection(context);
    if (status == DataConnectionStatus.connected)
    {
      isGetPublicReport = true;
      print('BlocProvider result: callPublicReportApi');
      BlocProvider.of<PublicReportBloc>(context).add(
          GetPublicReportsApi(
              stateId: '',
              districtId: '',
              date: ''
          )
      );
    }
    else
    {
      _showConnectionDialog(context);
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(checkConnection(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Home Page'),),
      drawer: DrawerLeft(),
      body: BlocProvider(
        create: (context) => PublicReportBloc(repository: repository),
        child: BlocBuilder<PublicReportBloc, PublicReportState>(
          builder: (context, state) {
            if (state is GetPublicReportInit)
            {
              print('GetPublicReportInit');
              // callgetReportApi(context);
              callPublicReportApi(context);
              // return initHomePage(context);
            }
            if (state is GetPublicReportLoading)
            {
              print('GetPublicReportLoading state');
              loadingView();
            }
            if (state is GetPublicReportSuccess)
            {
              print('GetPublicReport response homepage: ${state.response}');
              if(isGetPublicReport)
              {
                print('GetPublicReport response Success');
                isGetPublicReport = false;
                publicReportsResponse = state.response;
                print('publicReportsResponse : ${publicReportsResponse.topBlock.sites.total}');
              }
            }
            if(state is GetPublicReportError)
            {
              if(isGetPublicReport)
              {
                isGetPublicReport = false;
                print('GetPublicReport response error');
              }
            }
            return initHomePage(context);
          },
        ),
      )
    );
  }

  initHomePage(BuildContext context)
  {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          CarouselSlider(
              items: [
                BannerImage(
                  imagePath: '${AppConfig.getDefaultAssetsImage}/banner1.jpg',
                ),
                BannerImage(imagePath: '${AppConfig.getDefaultAssetsImage}/vaccine.jpg')
              ],
              options: CarouselOptions(autoPlay: true,
              height: 250,)
          ),
          reportView(context),
        ],
      ),
    );
  }

  reportView(BuildContext context)
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        Padding(
                          padding:EdgeInsets.all(5),
                          child: Text('Total Vaccination Doses',
                            style: TextStyle(
                                color: MainColors.total, fontFamily: 'RobotoMono', fontSize: 13),)),
                        Padding(
                          padding:EdgeInsets.all(5),
                          child: Text('${_calculateValueForLakh(publicReportsResponse.topBlock.vaccination.total_doses)} + lakh',
                          style: TextStyle(
                                color: MainColors.total, fontFamily: 'RobotoBold', fontSize: 16),),
                        ),
                        Padding(
                          padding:EdgeInsets.all(5),
                          child: Text('Today:+${publicReportsResponse.topBlock.vaccination.today}',
                          style: TextStyle(
                                color: MainColors.total, fontFamily: 'RobotoMono', fontSize: 14),),
                        )
                      ],

                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        Padding(
                          padding:EdgeInsets.all(5),
                          child: Text('AEFI Reported',
                            style: TextStyle(
                                color: MainColors.aefi, fontFamily: 'RobotoMono', fontSize: 13),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('${publicReportsResponse.topBlock.vaccination.aefi}',
                            style: TextStyle(
                                color: MainColors.aefi, fontFamily: 'RobotoBold', fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Today:+${publicReportsResponse.topBlock.vaccination.today_aefi}',
                            style: TextStyle(
                                color: MainColors.aefi, fontFamily: 'RobotoMono', fontSize: 14),),
                        )
                      ],

                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        Padding(
                            padding:EdgeInsets.all(5),
                            child: Text('Dose1 Vaccination',style: TextStyle(
                                color: MainColors.dose1, fontFamily: 'RobotoMono', fontSize: 13),)),
                        Padding(
                          padding:EdgeInsets.all(5),
                          child: Text('${_calculateValueForLakh(publicReportsResponse.topBlock.vaccination.total_dose1)} + lakh',
                          style: TextStyle(
                                color: MainColors.dose1, fontFamily: 'RobotoBold', fontSize: 16),),
                        ),
                        Padding(
                          padding:EdgeInsets.all(5),
                          child: Text('Today:+${publicReportsResponse.topBlock.vaccination.today_dose1}',
                          style: TextStyle(
                                color: MainColors.dose1, fontFamily: 'RobotoMono', fontSize: 14),),
                        )
                      ],

                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        Padding(
                          padding:EdgeInsets.all(5),
                          child: Text('Dose2 Vaccination',style: TextStyle(
                              color: MainColors.dose2, fontFamily: 'RobotoMono', fontSize: 13),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('${_calculateValueForLakh(publicReportsResponse.topBlock.vaccination.total_dose2)} + lakh',
                          style: TextStyle(
                                color: MainColors.dose2, fontFamily: 'RobotoBold', fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Today:+${publicReportsResponse.topBlock.vaccination.today_dose2}',
                          style: TextStyle(
                                color: MainColors.dose2, fontFamily: 'RobotoMono', fontSize: 14),),
                        )
                      ],

                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        Padding(
                            padding:EdgeInsets.all(5),
                            child: Text('Total Vaccinated-Male',style: TextStyle(
                                color: MainColors.male, fontFamily: 'RobotoMono', fontSize: 13),
                            )),
                        Padding(
                          padding:EdgeInsets.all(5),
                          child: Text('${_calculateValueForLakh(publicReportsResponse.topBlock.vaccination.male)} + lakh',
                          style: TextStyle(
                                color: MainColors.male, fontFamily: 'RobotoBold', fontSize: 16),),
                        ),
                        Padding(
                          padding:EdgeInsets.all(5),
                          child: Text('Today:+${publicReportsResponse.topBlock.vaccination.today_male}',
                          style: TextStyle(
                                color: MainColors.male, fontFamily: 'RobotoMono', fontSize: 14),),
                        )
                      ],

                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        Padding(
                          padding:EdgeInsets.all(5),
                          child: Text('Total Vaccinated-Female', style: TextStyle(
                            color: MainColors.female, fontFamily: 'RobotoMono', fontSize: 13
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('${_calculateValueForLakh(publicReportsResponse.topBlock.vaccination.female)} + lakh',
                          style: TextStyle(
                                color: MainColors.female, fontFamily: 'RobotoBold', fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Today:+${publicReportsResponse.topBlock.vaccination.today_female}',
                          style: TextStyle(
                                color: MainColors.female, fontFamily: 'RobotoMono', fontSize: 14),),
                        )
                      ],

                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _calculateValueForLakh(int number)
  {
    return (number / 100000).toStringAsFixed(2);
  }

  Widget loadingView() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SizedBox(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 1,
        ),
        height: 15.0,
        width: 15.0,
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

  void _showToast(String message) {
    Toast.show(message, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

}
