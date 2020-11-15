class Medication {
  final int id;
  final String name, type, route, strength, usage, image, dosage;
  final int categoryId, units;
  final double pricePerUnit;
  final int isFavourite, isPopular;

  Medication(
      {this.id,
      this.name,
      this.type,
      this.route,
      this.strength,
      this.usage,
      this.dosage,
      this.categoryId,
      this.units,
      this.image,
      this.pricePerUnit,
      this.isFavourite,
      this.isPopular});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
        id: json['id'],
        name: json['name'].toString(),
        type: json['type'].toString(),
        route: json['route'].toString(),
        strength: json['strength'].toString(),
        usage: json['usage'].toString(),
        dosage: json['dosage'].toString(),
        categoryId: json['category_id'],
        units: json['units'],
        image: json['image'].toString(),
        pricePerUnit: json['price_per_unit'],
        isFavourite: json['isFavourite'],
        isPopular: json['isPopular']);
  }
}
