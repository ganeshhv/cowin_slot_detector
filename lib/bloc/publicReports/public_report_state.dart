import 'package:cowin_slot_detector/models/publicReports/public_reports_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PublicReportState extends Equatable
{
  const PublicReportState();

  @override
  List<Object> get props => [];
}

class GetPublicReportInit extends PublicReportState {}

class GetPublicReportLoading extends PublicReportState {}

class GetPublicReportSuccess extends PublicReportState {
  final PublicReportsResponse response;
  const GetPublicReportSuccess({@required this.response}) :
      assert(response != null);
  @override
  List<Object> get props => [response];
}

class GetPublicReportError extends PublicReportState {}


