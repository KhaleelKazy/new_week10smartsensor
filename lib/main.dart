import 'dart:async';
import 'dart:math';

Future<String> fetchSensorMetadata() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Sensor ID: 402 | Location: Warehouse-A';
}

Stream<double> temperatureStream() async* {
  final random = Random();

  for (int i = 0; i < 5; i++) {
    yield 20.0 + random.nextDouble() * 22.0;

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

  final subscription = controller.stream.listen(
        (temperature) {
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
    },
    onError: (Object error) {
      print('SENSOR ALERT: $error');
      print('Continuing temperature monitoring...\n');
    },
    onDone: () {
      print('Temperature stream closed.');
    },
  );

  int counter = 0;

  await for (final reading in temperatureStream()) {
    counter++;

    if (counter == 4) {
      controller.addError(
        Exception('Sensor Malfunction: Signal Lost'),
      );
    } else {
      controller.add(reading);
    }
  }

  await controller.close();
  await subscription.asFuture<void>();

  print('\nTemperature monitoring complete.');
}