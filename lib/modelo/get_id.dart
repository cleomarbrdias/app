class RetornaId {
  final int id;

  RetornaId({required this.id});

  factory RetornaId.fromJson(Map<String, dynamic> json) {
    return RetornaId(
      id: json["id"],
    );
  }
}
