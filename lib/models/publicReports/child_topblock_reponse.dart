import 'package:cowin_slot_detector/models/publicReports/sessionResponse/child_session_response.dart';
import 'package:cowin_slot_detector/models/publicReports/siteResponse/child_site_response.dart';
import 'package:cowin_slot_detector/models/publicReports/vaccinationResponse/child_vaccinationResponse.dart';
import 'package:cowin_slot_detector/models/slotbypin/child_sessions_list_response.dart';
import 'package:equatable/equatable.dart';

import 'RegistrationResponse/child_registration_response.dart';

class ChildTopBlockResponse extends Equatable
{
  final ChildSitesResponse sites;
  final ChildSessionResponse sessions;
  final ChildRegistrationResponse registration;
  final ChildVaccinationResponse vaccination;

  const ChildTopBlockResponse({
    this.sites,
    this.sessions,
    this.registration,
    this.vaccination
  });

  @override
  List<Object> get props => [sites, sessions, registration, vaccination];



  static ChildTopBlockResponse fromJson(dynamic json)
  {
    var sitesResult;
    var sessionResult;
    var registrationResult;
    var vaccinationResult;

    json.forEach((key, value) {
      if(key == 'sites')
        {
          sitesResult = ChildSitesResponse.fromJson(value);
          print('${ChildSitesResponse.fromJson(value)} --> $sitesResult ');

        }
      else if(key == 'sessions')
      {
        sessionResult = ChildSessionResponse.fromJson(value);
      }else if(key == 'registration')
      {
        registrationResult = ChildRegistrationResponse.fromJson(value);
      }
      else
      {
        vaccinationResult = ChildVaccinationResponse.fromJson(value);
      }
    });

    print( 'from childTopBlock response json1 : ${sitesResult}');

    return ChildTopBlockResponse(
        sites: sitesResult,
        sessions: sessionResult,
        registration: registrationResult,
        vaccination: vaccinationResult
    );
  }

  @override
  String toString() =>
      'ChildTopBlockResponse sites:${sites} session:$sessions '
          'registration:$registration vaccination:${vaccination}';
}