import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'counter_state.dart';

part 'counter_cubit.g.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  CounterCubit() : super(CounterState(counter: 0));

  void increment() =>
      emit(CounterState(counter: state.counter! + 1, wasIncremented: true));

  void decrement() =>
      emit(CounterState(counter: state.counter! - 1, wasIncremented: false));

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    // everytimr there is a nre counter state emmited, we want to save its data to Map(Json)
    // and then send it to Hydrated Bloc to store it locally
    return state.toJson();
  }
}
