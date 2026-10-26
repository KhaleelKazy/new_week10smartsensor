
import 'dart:async';
import 'dart:math';

Future<String> fetchSensorMetadata() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Sensor ID: 402 | Location: Warehouse-A';
}

Stream<double> temperatureStream() async* {
  final random = Random();

  for (int i = 0; i < 5; i++) {
    final temperature = 20.0 + random.nextDouble() * 22.0;

    yield temperature;

    if (i < 4) {
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}

Future<void> main() async {
  final metadata = await fetchSensorMetadata();
  print(metadata);
  print('Initialization complete. Proceeding...\n');

  final controller = StreamController<double>();

  controller.stream.listen((temperature) {
    if (temperature > 35.0) {
      final fahrenheit = temperature * 1.8 + 32;

      print(
        'WARNING: High temperature! '
            '${temperature.toStringAsFixed(1)}°C '
            '(${fahrenheit.toStringAsFixed(1)}°F)',
      );
    } else {
      print(
        'Normal temperature: '
            '${temperature.toStringAsFixed(1)}°C',
      );
    }
  });

  await for (final reading in temperatureStream()) {
    controller.add(reading);
  }

  await controller.close();

  print('\nTemperature monitoring complete.');
}
