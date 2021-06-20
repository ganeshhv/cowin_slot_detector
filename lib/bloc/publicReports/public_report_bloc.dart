import 'package:cowin_slot_detector/bloc/publicReports/public_report_event.dart';
import 'package:cowin_slot_detector/bloc/publicReports/public_report_state.dart';
import 'package:cowin_slot_detector/models/publicReports/public_reports_response.dart';
import 'package:cowin_slot_detector/repository/public_report_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicReportBloc extends Bloc<PublicReportEvent, PublicReportState>
{
  final PublicReportRepository repository;

  // initialize repository
  PublicReportBloc({@required this.repository}) : assert(repository != null);

  @override
  PublicReportState get initialState => GetPublicReportInit();

  @override
  Stream<PublicReportState> mapEventToState(PublicReportEvent event) async*
  {
    print('PublicReportBloc event: $event');

    if(event is GetPublicReportsApi)
      {
        yield GetPublicReportLoading();
        try
        {
          print('PublicReportBloc success');
          final PublicReportsResponse response =
              await repository.getPublicReportApi(event.stateId, event.districtId, event.date);
          yield GetPublicReportSuccess(response: response);
          print('GetPublicReportSuccess from Bloc: $response');
        }
        catch(e)
        {
          print('PublicReportBloc error $e');
        }
      }
  }


}