import 'package:aphasia/constants.dart';
import 'package:aphasia/providers/tts_provider.dart';
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

  late double volumeValue;
  late double speedValue;
  late double pitchValue;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    resetValues();
    super.initState();
  }

  void resetValues() {
    volumeValue = UserProvider.getVolume;
    speedValue = UserProvider.getSpeed;
    pitchValue = UserProvider.getPitch;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Impostazioni"),
        actions: [
          IconButton(
            tooltip: "Reset",
            onPressed: () async {
              await UserProvider.reset();
              resetValues();
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: kMediumSize),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(kMediumSize),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SettingsSectionTitle(text: "Impostazioni Utente"),
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
              const SizedBox(height: kLargeSize),
              const SettingsSectionTitle(text: "Impostazioni Voce"),
              const SizedBox(height: kMediumSize),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(Icons.volume_up_rounded),
                  Expanded(
                    child: Slider(
                      label: "Volume: ${(volumeValue * 100).toInt()}%",
                      value: volumeValue,
                      divisions: 10,
                      onChangeEnd: (value) {
                        UserProvider.setVolumeTo(value);
                      },
                      onChanged: (double value) {
                        volumeValue = value;
                        setState(() {});
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
                      label: "Velocità: ${speedValue + 0.5}",
                      value: speedValue,
                      divisions: 4,
                      onChangeEnd: (value) {
                        UserProvider.setSpeedTo(value);
                      },
                      onChanged: (double value) {
                        speedValue = value;
                        setState(() {});
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
                      label: "Tono: $pitchValue",
                      min: 0.5,
                      max: 2,
                      divisions: 3,
                      value: pitchValue,
                      onChangeEnd: (value) {
                        UserProvider.setPitchTo(value);
                      },
                      onChanged: (double value) {
                        pitchValue = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kMediumSize),
              Row(
                children: [
                  const Text("Prova voce: "),
                  IconButton(
                    onPressed: () =>
                        TTSProvider.speak(UserProvider.getUserName),
                    icon: const Icon(Icons.volume_up_rounded),
                  ),
                ],
              ),
              const SizedBox(height: kLargeSize),
              const SettingsSectionTitle(text: "Impostazioni disposizione"),
              const SizedBox(height: kMediumSize),
              Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  colorScheme: ColorScheme.fromSeed(seedColor: kBaseColor),
                ),
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Disponi elementi visivi a sinistra"),
                  subtitle: const Text(
                    "Agevola le persone mancine nell'utilizzo dell'applicazione",
                  ),
                  thumbIcon: MaterialStateProperty.all<Icon>(
                    UserProvider.getIsRightToLeft
                        ? const Icon(Icons.done)
                        : const Icon(Icons.close),
                  ),
                  value: UserProvider.getIsRightToLeft,
                  onChanged: (bool value) {
                    UserProvider.toggleRTL();
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: kLargeSize),
              const Text(
                "Numero di parole per riga",
                style: TextStyle(fontSize: kMediumSize),
              ),
              Slider(
                value: UserProvider.getNumberOfCardsPerRow.toDouble(),
                divisions: 3,
                min: 1,
                max: 4,
                label: UserProvider.getNumberOfCardsPerRow.toString(),
                onChanged: (double value) {
                  UserProvider.setCardsPerRowTo(value.toInt());
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsSectionTitle extends StatelessWidget {
  const SettingsSectionTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          text,
          style: theme.textTheme.bodyLarge!.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ],
    );
  }
}
