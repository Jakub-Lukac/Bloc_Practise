import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:bloc_to_bloc/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  // response to connectivity_plus package
  final Connectivity connectivity;
  // internetCubit listening to Connectivity stream from connectivity_plus package
  StreamSubscription? connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    // every time a new connectivity type is noticed by connectivity_plus
    // the onConnectivityChange will send a new stream
    // our internetCubit listens to these streams
    // want to emit new InternetState accordingly to a new stream
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
      connectivity.onConnectivityChanged.listen((connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      emitInternedConnection(ConnectionType.wifi);
    } else if (connectivityResult == ConnectivityResult.mobile) {
      emitInternedConnection(ConnectionType.mobile);
    } else if (connectivityResult == ConnectivityResult.none) {
      emitInternedDisconnected();
    }
  });
  }

  void emitInternedConnection(ConnectionType _connectionType) => emit(
        InternetConnected(
          connectionType: _connectionType,
        ),
      );

  void emitInternedDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
