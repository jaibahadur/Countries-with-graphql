class Country {
  String name = "", continent = "", phone = "", code = "", emoji = "";
  List<String> languages = List.empty();

  Country({
    required this.name,
    required this.continent,
    required this.phone,
    required this.code,
    required this.emoji,
    required this.languages,
  });

  Country.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    if (map['continent'] != null) {
      continent = map['continent']['name'];
    }
    phone = map['phone'];
    code = map['code'];
    emoji = map['emoji'];
    languages = (map['languages'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map<String>((l) => l['name'])
        .toList();
  }
}
