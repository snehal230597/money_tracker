class AddEntryModel {
  final int key;
  final String type;
  final double amount;
  final String description;
  final String date;

  AddEntryModel({
    required this.key,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });
}