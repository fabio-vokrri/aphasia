import 'package:aphasia/constants.dart';
import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/view/pages/home.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final textController = TextEditingController(text: UserProvider.getUserName);

  double _volumeValue = 0.5;
  double _speedValue = 0.5;
  double _toneValue = 0.5;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Impostazioni")),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(kMediumSize),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Impostazioni Utente",
                style: TextStyle(color: theme.primaryColor),
              ),
              const SizedBox(height: kLargeSize),
              TextFormField(
                maxLength: 15,
                controller: textController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  label: Text("Modifica il tuo nome utente"),
                ),
                onFieldSubmitted: (String newName) {
                  if (newName.isNotEmpty) {
                    UserProvider.setUserName(newName);
                  }
                },
              ),
              const SizedBox(height: kMediumSize),
              Text(
                "Impostazioni Voce",
                style: TextStyle(color: theme.primaryColor),
              ),
              const SizedBox(height: kMediumSize),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(Icons.volume_up_rounded),
                  Expanded(
                    child: Slider(
                      label: "Volume: ${(_volumeValue * 100).toInt()}%",
                      divisions: 4,
                      value: _volumeValue,
                      onChanged: (double value) {
                        setState(() => _volumeValue = value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kMediumSize),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(Icons.speed),
                  Expanded(
                    child: Slider(
                      label: "Velocità: ${_speedValue + 0.5}x",
                      divisions: 4,
                      value: _speedValue,
                      onChanged: (double value) {
                        setState(() => _speedValue = value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kMediumSize),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(Icons.record_voice_over),
                  Expanded(
                    child: Slider(
                      label: "Tono: ${(_toneValue * 100).toInt()}%",
                      divisions: 4,
                      value: _toneValue,
                      onChanged: (double value) {
                        setState(() => _toneValue = value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
