import 'package:intl/intl.dart';

const _today = 'Hoje';

String _formatDay(DateTime date) {
  if (date.day == DateTime.now().day) {
    return _today;
  }
  return toBeginningOfSentenceCase(
          DateFormat(DateFormat.ABBR_WEEKDAY).format(date)) ??
      DateFormat(DateFormat.ABBR_WEEKDAY).format(date);
}

String formatDate(DateTime date) {
  final day = _formatDay(date);
  if (day == _today) {
    return '$day - ${DateFormat('HH:mm').format(date)}';
  }
  return '$day - ${DateFormat('dd MMM yyyy - HH:mm').format(date)}';
}
