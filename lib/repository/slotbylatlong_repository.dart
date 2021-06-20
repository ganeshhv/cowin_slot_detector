import 'package:cowin_slot_detector/models/slotbylatlong/slot_by_latlong_response.dart';
import 'package:cowin_slot_detector/repository/api_client.dart';
import 'package:flutter/cupertino.dart';

class SlotByLatLongRepository
{
  final ApiClient apiClient;

  SlotByLatLongRepository({@required this.apiClient}) : assert(apiClient != null);

  // // change resonse here
  // Future<SlotByLatLongResponse> getSlotByLatLongApi(double lat, double long) async
  // {
  //   return await apiClient.serverGetSlotLatLonResponse(lat,long);
  // }
}