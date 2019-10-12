class SingleHistoryItem {
  String value;
  DateTime createdAt;

  SingleHistoryItem({ this.value, this.createdAt });

  void setCreatedAt(DateTime dateToSet) {
    createdAt = dateToSet;
  }

  void setValue(String valueToSet) {
    value = valueToSet;
  }

  factory SingleHistoryItem.fromJson(Map<String, dynamic> json) {
    return new SingleHistoryItem(
      value: json['value'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Map<String, dynamic> toJson() => {
    'value': value,
    'createdAt': createdAt.toIso8601String(),
  };
}
