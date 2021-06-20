import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class OneWeekSlotEvent extends Equatable
{
  const OneWeekSlotEvent();
}

class GetOneweekSlotApi extends OneWeekSlotEvent
{
  final String date;
  final String pincode;

  const GetOneweekSlotApi({
    @required this.date,
    @required this.pincode
  }) : assert(date != null && pincode != null);

  @override
  List<Object> get props => [date, pincode];
}