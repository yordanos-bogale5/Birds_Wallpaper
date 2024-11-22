import 'package:intl/intl.dart';

import 'convert_utc_to_local_timezone.dart';

String convertDateToYear(String date) {
  try {
    return DateFormat('yyyy').format(convertUtcToLocal(date));
  } catch (e) {
    return date;
  }
}
