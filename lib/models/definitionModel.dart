class DefinitionModel {
  final String definition;
  final String? example;

  DefinitionModel({
    required this.definition,
    this.example
  });

  Map<String, String> toJson() {
    return {
      "definition": definition,
      if (example != null) "example": example!
    };
  }

  static DefinitionModel fromJson(Map<String, String> data) {
    return DefinitionModel(
      definition: data["definition"]!,
      example: data.containsKey("example") ? data["example"] : null
    );
  }
}