import 'package:cowin_slot_detector/bloc/slotbylatlong/slotby_latlong_event.dart';
import 'package:cowin_slot_detector/bloc/slotbylatlong/slotby_latlong_state.dart';
import 'package:cowin_slot_detector/models/slotbylatlong/slot_by_latlong_response.dart';
import 'package:cowin_slot_detector/repository/slotbylatlong_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SlotByLatLongBloc extends Bloc<SlotByLatLongEvent, SlotByLatLongState> {

  final SlotByLatLongRepository repository;

  SlotByLatLongBloc({@required this.repository}) : assert(repository != null);

  @override
  SlotByLatLongState get initialState => GetSlotByLatLongInit();

  @override
  Stream<SlotByLatLongState> mapEventToState(SlotByLatLongEvent event) async*
  {
    print('SlotByLatLongBloc event: $event');

    if(event is GetSlotByLatLongApi)
      {
        yield GetSlotByLatLongLoading();
        try {
          print('GetSlotByLatLong Success');
          // final SlotByLatLongResponse response =
          // await repository.getSlotByLatLongApi(event.lat, event.long);
          // yield GetSlotByLatLongSuccess(response: response);
        }
        catch(e) {
          print('GetSlotByLatLong Error: $e');
        }
      }
  }

}