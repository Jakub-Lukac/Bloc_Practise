part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool? appNotification;
  final bool? emailNotification;

  const SettingsState({
    required this.appNotification,
    required this.emailNotification,
  });

  SettingsState copyWith({
    bool appNotification = false,
    bool emailNotification = false,
  }) {
    return SettingsState(
      appNotification: appNotification,
      emailNotification: emailNotification,
    );
  }
  
  @override
  List<Object?> get props => [appNotification, emailNotification];
}
