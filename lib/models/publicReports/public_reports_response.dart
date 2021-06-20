import 'package:cowin_slot_detector/models/publicReports/RegistrationResponse/child_registration_response.dart';
import 'package:cowin_slot_detector/models/publicReports/sessionResponse/child_session_response.dart';
import 'package:cowin_slot_detector/models/publicReports/siteResponse/child_site_response.dart';
import 'package:cowin_slot_detector/models/publicReports/vaccinationResponse/child_vaccinationResponse.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'child_topblock_reponse.dart';

class PublicReportsResponse extends Equatable {
  final ChildTopBlockResponse topBlock;
  // final List vaccineDoneByTime;
  // final List last7DaysRegistration;
  // final List last30DaysAefi;
  // final List last5daySessionStatus;
  // final List getBeneficiariesGroupBy;
  // final double aefiPercentage;
  // final List vaccinationByAge;
  // final List timeWiseTodayRegReport;
  // final List vaccinationDoneByTimeAgeWise;
  // final String timeStamp;



  const PublicReportsResponse({
    this.topBlock,
    // this.vaccineDoneByTime,
    // this.last7DaysRegistration,
    // this.last30DaysAefi,
    // this.last5daySessionStatus,
    // this.getBeneficiariesGroupBy,
    // this.aefiPercentage,
    // this.vaccinationByAge,
    // this.timeWiseTodayRegReport,
    // this.vaccinationDoneByTimeAgeWise,
    // this.timeStamp
  });

  @override
  List<Object> get props => [topBlock];

  static PublicReportsResponse fromJson(dynamic json)
  {
    var result;
    var res;
    json.forEach((key,value) {
      if (key == 'topBlock')
        {
          result = ChildTopBlockResponse.fromJson(value);
          // value.forEach((key1, value1) {
          //   print('PublicReportsResponse from json $key1 - $value1');
          //   result = ChildTopBlockResponse.fromJson(json['$key']);
          //   print('result:--->$result');
          //   // if(key1 == 'sites') res = ChildSitesResponse.fromJson(key1);
          //   // else if(key1 == 'sessions') res = ChildSessionResponse.fromJson(key1);
          //   // else if(key1 == 'registration') res = ChildRegistrationResponse.fromJson(key1);
          //   // else if(key1 == 'vaccination') res = ChildVaccinationResponse.fromJson(key1);
          //   // print('res1:$res');
          // });
        }
    });
    // print('PublicReportsResponse fromJson 2 ${result.sites}');
    // print('PublicReportsResponse fromJson 2 ${result.sessions}');
    // print('PublicReportsResponse fromJson 2 ${result.registration}');
    //
    // print('PublicReportsResponse fromJson 2 ${result.sites}');

    return PublicReportsResponse(
      topBlock: (result == null) ? [] : result
    );
  }


  @override
  String toString() => 'PublicReportsResponse {topBlock: ${topBlock} }';

}