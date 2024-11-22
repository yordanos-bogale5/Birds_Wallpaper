DateTime convertUtcToLocal(String utcTimeString) {
  // Parse the UTC string into a DateTime object
  DateTime utcDateTime = DateTime.parse(utcTimeString);

  // Convert UTC time to local time
  DateTime localDateTime = utcDateTime.toLocal();

  return localDateTime;
}
