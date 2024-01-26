part of 'internet_cubit.dart';

@immutable
sealed class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState{
  // either by mobil(data) or wifi
  final ConnectionType? connectionType;

  InternetConnected({required this.connectionType});
}

class InternetDisconnected extends InternetState{}

