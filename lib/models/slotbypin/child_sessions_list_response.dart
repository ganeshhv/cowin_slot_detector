import 'package:equatable/equatable.dart';

class ChildSessionsListResponse extends Equatable
{
  final String sessionId;
  final String date;
  final int availableCapacity;
  final int minAgeLimit;
  final String vaccine;
  final List slots;
  final int availableCapacityDose1;
  final int availableCapacityDose2;

  ChildSessionsListResponse
      ({
      this.sessionId,
      this.date,
      this.availableCapacity,
      this.minAgeLimit,
      this.vaccine,
      this.slots,
      this.availableCapacityDose1,
      this.availableCapacityDose2
      });
  @override
  // TODO: implement props
  List<Object> get props => [
    sessionId,
    date,
    availableCapacity,
    minAgeLimit,
    vaccine,
    slots,
    availableCapacityDose1,
    availableCapacityDose2
  ];

  static ChildSessionsListResponse fromJson(dynamic json)
  {
    return ChildSessionsListResponse(
        sessionId: json['session_id'] == null ? '' : json['session_id'],
        date: json['date'] == null ? '' : json['date'],
        availableCapacity: json['available_capacity'] == null ? 0 : json['available_capacity'],
        minAgeLimit: json['min_age_limit'] == null ? 0 : json['min_age_limit'],
        vaccine: json['vaccine'] == null ? '' : json['vaccine'],
        slots: (json['slots'] as List)
              .map((i) => i)
          .toList(),
        availableCapacityDose1: json['available_capacity_dose1'] == null ? 0 : json['available_capacity_dose1'],
        availableCapacityDose2: json['available_capacity_dose2'] == null ? 0 : json['available_capacity_dose2']
    );
  }


}