class FormModel {
  final int? id;
  final String firstName;
  final String lastName;
  final String secfirstName;
  final String seclastName;
  final String primaryEmail;
  final String secEmail;
  final String phoneNumber;
  final String secphoneNumber;
  final int totalMonths;
  final String spaceNumber;
  final String licensePlate;
  final String accessCardNumber;
  final String description;
  final String startDate;

  FormModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.secfirstName,
    required this.seclastName,
    required this.primaryEmail,
    required this.phoneNumber,
    required this.secEmail,
    required this.secphoneNumber,
    required this.totalMonths,
    required this.spaceNumber,
    required this.licensePlate,
    required this.accessCardNumber,
    required this.description,
    required this.startDate,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'secfirstName': secfirstName,
      'seclastName': seclastName,
      'primaryEmail': primaryEmail,
      'phoneNumber': phoneNumber,
      'secEmail': secEmail,
      'secphoneNumber': secphoneNumber,
      'totalMonths': totalMonths,
      'spaceNumber': spaceNumber,
      'licensePlate': licensePlate,
      'accessCardNumber': accessCardNumber,
      'description': description,
      'startDate': startDate,
    };
  }
}
