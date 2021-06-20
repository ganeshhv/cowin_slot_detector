import 'dart:convert';

import 'package:cowin_slot_detector/models/publicReports/public_reports_response.dart';
import 'package:cowin_slot_detector/models/slotbylatlong/slot_by_latlong_response.dart';
import 'package:cowin_slot_detector/models/slotbypin/oneweek_slot_by_pin_response.dart';
import 'package:cowin_slot_detector/utils/app_config.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;

class ApiClient
{
  final http.Client httpClient;

  var getPublicReports = "${AppConfig.getBaseUrlApi}/v1/reports/v2/getPublicReports";
  var getSlotByPin = "${AppConfig.getBaseUrlApi}/v2/appointment/sessions/public/findByPin";
  var getOneweekSlotByPin = "${AppConfig.getBaseUrlApi}/v2/appointment/sessions/public/calendarByPin";
  // var getSlotByLatLong = "${AppConfig.getBaseUrlApi}/v2/appointment/centers/public/findByLatLong";

  ApiClient({
    @required this.httpClient
  }) : assert(httpClient != null);

  Future<PublicReportsResponse> serverGetPublicReport(String stateId, String districtId, String date ) async
  {
    var url = getPublicReports;
    final String path = '$url?state_id=$stateId&district_id=$districtId&date=$date';

    final response = await this.httpClient.get(path,
    headers: {
      "Content-Type": "application/json"
    });
    print('serverGetPublicReport header: $path');
    print('serverGetPublicReport status: ${response.statusCode}');
    print('serverGetPublicReport body: ${response.body}');

    if(response.statusCode != 200)
      {
        throw Exception('Error getting quotes');
      }

    final json = jsonDecode(response.body);
    print('serverGetPublicReport result: $json');
    final result = PublicReportsResponse.fromJson(json);
    print('from apiClient:-> $result');
    // List<PublicReportsResponse> listModel;
    // for(Map i in json)
    //   {
    //     listModel.add(PublicReportsResponse.fromJson(i));
    //   }
    return result;
  }

  Future<OneweekSlotByPinResponse> serverGetOneWeekResponse(String date, String pincode) async
  {
    var url = getOneweekSlotByPin;
    final String path = '$url?pincode=$pincode&date=$date';
    final response = await this.httpClient.get(path,
    headers: {
      "Content-Type": "application/json"
    });
    print('serverGetOneWeekResponse header: $path');
    print('serverGetOneWeekResponse status: ${response.statusCode}');
    print('serverGetOneWeekResponse body: ${response.body}');

    if(response.statusCode != 200)
      {
        throw Exception('error getting quotes');
      }

    final json = jsonDecode(response.body);
    print('serverGetOneWeekResponse result: $json');
    final result = OneweekSlotByPinResponse.fromJson(json);
    return result;
  }
  Future<OneweekSlotByPinResponse> serverGetSlotByPinResponse(String date, String pincode) async
  {
    var url = getSlotByPin;
    final String path = '$url?pincode=$pincode&date=$date';
    final response = await this.httpClient.get(path,
        headers: {
          "Content-Type": "application/json"
        });
    print('serverGetSlotByPinResponse header: $path');
    print('serverGetSlotByPinResponse status: ${response.statusCode}');
    print('serverGetSlotByPinResponse body: ${response.body}');

    if(response.statusCode != 200)
    {
      throw Exception('error getting quotes');
    }

    final json = jsonDecode(response.body);
    print('serverGetSlotByPinResponse result: $json');
    final result = OneweekSlotByPinResponse.fromJson(json);
    return result;
  }
  // Future<SlotByLatLongResponse> serverGetSlotLatLonResponse(double lat, double long) async
  // {
  //   var url = getSlotByPin;
  //   final String path = '$url?lat=$lat&long=$long';
  //   final response = await this.httpClient.get(path,
  //       headers: {
  //         "Content-Type": "application/json"
  //       });
  //   print('serverGetSlotLatLonResponse header: $path');
  //   print('serverGetSlotLatLonResponse status: ${response.statusCode}');
  //   print('serverGetSlotLatLonResponse body: ${response.body}');
  //
  //   if(response.statusCode != 200)
  //   {
  //     throw Exception('error getting quotes');
  //   }
  //
  //   final json = jsonDecode(response.body);
  //   print('serverGetSlotLatLonResponse result: $json');
  //   final result = SlotByLatLongResponse.fromJson(json);
  //   return result;
  // }

}