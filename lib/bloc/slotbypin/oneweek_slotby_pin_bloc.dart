import 'package:cowin_slot_detector/models/slotbypin/oneweek_slot_by_pin_response.dart';
import 'package:cowin_slot_detector/repository/slotbypin_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'oneweek_slotby_pin_event.dart';
import 'oneweek_slotby_pin_state.dart';

class OneWeekSlotBloc extends Bloc<OneWeekSlotEvent, OneWeekSlotState>
{
  final SlotByPinRepository repository;

  OneWeekSlotBloc({@required this.repository}) : assert(repository != null);

  @override
  // TODO: implement initialState
  OneWeekSlotState get initialState => GetOneWeekSlotInit();

  @override
  Stream<OneWeekSlotState> mapEventToState(OneWeekSlotEvent event) async* {
    print('OneweekslotBloc event: $event');

    if(event is GetOneweekSlotApi)
      {
        yield GetOneWeekSlotLoading();
        try {
          print('GetOneweekslotApi Success');
          final OneweekSlotByPinResponse response = await
              repository.getOneWeekSlotApi(event.date, event.pincode);
          yield GetOneWeekSlotSuccess(response: response);
        } catch(e) {
          print('GetOneweekslotApi Error: $e');
          yield GetOneWeekSlotError();
        }
      }
  }


}