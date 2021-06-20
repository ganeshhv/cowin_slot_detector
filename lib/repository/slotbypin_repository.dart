import 'package:cowin_slot_detector/models/slotbypin/oneweek_slot_by_pin_response.dart';
import 'package:cowin_slot_detector/repository/api_client.dart';
import 'package:flutter/cupertino.dart';

class SlotByPinRepository {
  final ApiClient apiClient;

  SlotByPinRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<OneweekSlotByPinResponse> getOneWeekSlotApi(String date, String pincode) async
  {
    return await apiClient.serverGetOneWeekResponse(date,pincode);
  }

  Future<OneweekSlotByPinResponse> getSlotByPinApi(String date, String pincode) async
  {
    return await apiClient.serverGetSlotByPinResponse(date,pincode);
  }


}