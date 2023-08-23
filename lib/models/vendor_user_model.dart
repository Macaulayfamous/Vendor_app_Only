class VendorUserModel {
  final bool approved;

  final String bussinessName;

  final String cityValue;

  final String countryValue;

  final String emailAddress;

  final String stateValue;

  final String storeImage;

  final String vendorId;

  VendorUserModel(
      {required this.approved,
      required this.bussinessName,
      required this.cityValue,
      required this.countryValue,
      required this.emailAddress,
      required this.stateValue,
      required this.storeImage,
      required this.vendorId});

  VendorUserModel.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool,
          bussinessName: json['bussinessName']! as String,
          cityValue: json['cityValue']! as String,
          countryValue: json['countryValue']! as String,
          emailAddress: json['emailAddress']! as String,
          stateValue: json['stateValue']! as String,
          storeImage: json['storeImage']! as String,
          vendorId: json['vendorId']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'bussinessName': bussinessName,
      'cityValue': cityValue,
      'countryValue': countryValue,
      'emailAddress': emailAddress,
      'stateValue': stateValue,
      'storeImage': storeImage,
      'vendorId': vendorId,
    };
  }
}
