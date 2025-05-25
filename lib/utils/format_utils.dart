import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final formatter = DateFormat('dd MMMM yyyy');
  return formatter.format(date);
}
String formatRupiah(double amount) {
  return 'Rp ' +
      amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.');
}