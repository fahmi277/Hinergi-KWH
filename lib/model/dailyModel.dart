class Daily {
  int id;
  String name;

  Daily({this.id, this.name});

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      id: json['id'],
      name: json['NAME'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['NAME'] = this.name;
    return data;
  }
}
