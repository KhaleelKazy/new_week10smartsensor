Future<String> fetchSensorMetadata() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Sensor ID: 402 | Location: Warehouse-A';
}

Future<void> main() async {
  final metadata = await fetchSensorMetadata();
  print(metadata);
  print('Initialization complete. Proceeding...');
}