import 'package:aphasia/constants.dart';
import 'package:aphasia/providers/settings_provider.dart';
import 'package:aphasia/providers/tts_provider.dart';
import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/view/components/reset_dialog.dart';
import 'package:aphasia/view/pages/home.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late double volumeValue;
  late double speedValue;
  late double pitchValue;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    resetValues();
    super.initState();
  }

  void resetValues() {
    volumeValue = SettingsProvider.getVolume;
    speedValue = SettingsProvider.getSpeed;
    pitchValue = SettingsProvider.getPitch;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Impostazioni"),
        actions: [
          IconButton(
            tooltip: "Reset",
            onPressed: () {
              _focusNode.unfocus();
              showDialog(
                context: context,
                builder: (context) => const ResetDialog(),
              ).then((value) {
                if (value is bool && value) {
                  resetValues();
                }
              });
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
              Text(
                "Impostazioni utente",
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: theme.primaryColor),
              ),
              const SizedBox(height: kMediumSize),
              TextFormField(
                maxLength: 15,
                controller: _textController,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  label: Text("Modifica il tuo nome"),
                ),
                onTap: () {
                  setState(() {
                    _textController.text = UserProvider.getUserName;
                  });
                },
                onFieldSubmitted: (String value) {
                  if (value.isNotEmpty && value != UserProvider.getUserName) {
                    UserProvider.setUserName(value);
                  }
                },
              ),
              const Divider(height: kLargeSize * 2),
              Text(
                "Impostazioni voce",
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: theme.primaryColor),
              ),
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
                        SettingsProvider.setVolumeTo(value);
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
                        SettingsProvider.setSpeedTo(value);
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
                        SettingsProvider.setPitchTo(value);
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
              ElevatedButton.icon(
                onPressed: () {
                  TTSProvider.speak(UserProvider.getUserName);
                },
                icon: const Icon(Icons.volume_up),
                label: const Text("Prova impostazioni voce"),
              ),
              const Divider(height: kLargeSize * 2),
              Text(
                "Impostazioni disposizione",
                style: theme.textTheme.bodyLarge!
                    .copyWith(color: theme.primaryColor),
              ),
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
                    SettingsProvider.getIsRightToLeft
                        ? const Icon(Icons.done)
                        : const Icon(Icons.close),
                  ),
                  value: SettingsProvider.getIsRightToLeft,
                  onChanged: (bool value) {
                    SettingsProvider.toggleRTL();
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: kMediumSize),
              Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  colorScheme: ColorScheme.fromSeed(seedColor: kBaseColor),
                ),
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Rimuovi animazioni"),
                  subtitle: const Text(
                    "Previene gli elementi visivi dall'avere animazioni",
                  ),
                  thumbIcon: MaterialStateProperty.all<Icon>(
                    SettingsProvider.getAnimationsAreRemoved
                        ? const Icon(Icons.done)
                        : const Icon(Icons.close),
                  ),
                  value: SettingsProvider.getAnimationsAreRemoved,
                  onChanged: (bool value) {
                    SettingsProvider.toggleAnimations();
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: kMediumSize),
              Text(
                "Numero di parole per riga",
                style: theme.textTheme.bodyLarge,
              ),
              Slider(
                value: SettingsProvider.getNumberOfCardsPerRow.toDouble(),
                divisions: 3,
                min: 1,
                max: 4,
                label: SettingsProvider.getNumberOfCardsPerRow.toString(),
                onChanged: (double value) {
                  SettingsProvider.setCardsPerRowTo(value.toInt());
                  setState(() {});
                },
              ),
              const SizedBox(height: kLargeSize * 2),
            ],
          ),
        ),
      ),
    );
  }
}
