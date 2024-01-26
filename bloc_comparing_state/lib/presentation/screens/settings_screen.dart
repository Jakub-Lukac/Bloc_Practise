import 'package:bloc_comparing_state/logic/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings "),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          final notificationSnackBar = SnackBar(
            duration: const Duration(
              milliseconds: 700,
            ),
            content: Text(
              "App ${state.appNotification.toString().toUpperCase()}, Email ${state.emailNotification.toString().toUpperCase()}",
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(notificationSnackBar);
        },
        builder: (context, state) {
          return Column(
            children: [
              SwitchListTile(
                value: state.appNotification!,
                onChanged: (value) {
                  context.read<SettingsCubit>().toggleAppNotification(value);
                },
                title: const Text("App Notication"),
              ),
              SwitchListTile(
                value: state.emailNotification!,
                onChanged: (value) {
                  context.read<SettingsCubit>().toggleEmailNotification(value);
                },
                title: const Text("App Notication"),
              ),
            ],
          );
        },
      ),
    );
  }
}
