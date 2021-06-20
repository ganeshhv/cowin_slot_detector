import 'package:cowin_slot_detector/models/publicReports/public_reports_response.dart';
import 'package:cowin_slot_detector/repository/api_client.dart';
import 'package:flutter/cupertino.dart';

class PublicReportRepository {
  final ApiClient apiClient;

  PublicReportRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<PublicReportsResponse> getPublicReportApi(String stateId, String districtId, String date) async
  {
    return await apiClient.serverGetPublicReport(stateId, districtId, date);
  }
}