import 'package:equatable/equatable.dart';

class ChildVaccinationResponse extends Equatable
{
  final int total;
  final int male;
  final int female;
  final int others;
  final int covishield;
  final int covaxin;
  final int sputnik;
  final int today;
  final int total_dose1;
  final int total_dose2;
  final int total_doses;
  final int aefi;
  final int today_dose1;
  final int today_dose2;
  final int today_female;
  final int today_male;
  final int today_others;
  final int today_aefi;





  const ChildVaccinationResponse({
    this.total,
    this.male,
    this.female,
    this.others,
    this.covishield,
    this.covaxin,
    this.sputnik,
    this.today,
    this.total_dose1,
    this.total_dose2,
    this.total_doses,
    this.aefi,
    this.today_dose1,
    this.today_dose2,
    this.today_female,
    this.today_male,
    this.today_others,
    this.today_aefi
  });
  @override
  List<Object> get props => [
    total,
    male,
    female,
    others,
    covishield,
    covaxin,
    sputnik,
    today,
    total_dose1,
    total_dose2,
    total_doses,
    aefi,
    today_dose1,
    today_dose2,
    today_female,
    today_male,
    today_others,
    today_aefi
  ];

  static ChildVaccinationResponse fromJson(dynamic json)
  {
    return ChildVaccinationResponse(
        total: json['total'] == null ? 0 : json['total'],
        male: json['male'] == null ? 0 : json['male'],
        female: json['female'] == null ? 0 : json['female'],
        others: json['others'] == null ? 0 : json['others'],
        covishield: json['covishield'] == null ? 0 : json['covishield'],
        covaxin: json['covaxin'] == null ? 0 : json['covaxin'],
        sputnik: json['sputnik'] == null ? 0 : json['sputnik'],
        today: json['today'] == null ? 0 : json['today'],
        total_dose1: json['tot_dose_1'] == null ? 0 : json['tot_dose_1'],
        total_dose2: json['tot_dose_2'] == null ? 0 : json['tot_dose_2'],
        total_doses: json['total_doses'] == null ? 0 : json['total_doses'],
        aefi: json['aefi'] == null ? 0 : json['aefi'],
        today_dose1: json['today_dose_one'] == null ? 0 : json['today_dose1'],
        today_dose2: json['today_dose_two'] == null ? 0 : json['today_dose2'],
        today_female: json['today_female'] == null ? 0 : json['today_female'],
        today_male: json['today_male'] == null ? 0 : json['today_male'],
        today_others: json['today_others'] == null ? 0 : json['today_others'],
        today_aefi: json['today_aefi'] == null ? 0 : json['today_aefi']

    );
  }
  @override
  String toString() => 'from ChildVaccinationResponse() -> $total';
}