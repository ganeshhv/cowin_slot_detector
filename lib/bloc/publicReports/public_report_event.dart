import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PublicReportEvent extends Equatable
{
  const PublicReportEvent();
}

class GetPublicReportsApi extends PublicReportEvent
{
  final String stateId;
  final String districtId;
  final String date;

  const GetPublicReportsApi({
    @required this.stateId,
    @required this.districtId,
    @required this.date
  }) : assert(stateId != null && districtId != null && date != null);

  @override
  List<Object> get props => [stateId, districtId, date];
}