import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../assets/core/app_colors.dart';
import '../../assets/core/app_style.dart';
import '../../database/indoor_data.dart';
import '../../services/print_forms/printing.dart';

class LeaseAgreementScreen extends StatefulWidget {
  final Map<String, dynamic> formData; // Receive form data
  const LeaseAgreementScreen({super.key, required this.formData});

  @override
  State<LeaseAgreementScreen> createState() => _LeaseAgreementScreenState();
}

class _LeaseAgreementScreenState extends State<LeaseAgreementScreen> {
  // Controllers for editable fields
  final TextEditingController effectiveDateController = TextEditingController();
  final TextEditingController lesseeNameController = TextEditingController();
  final TextEditingController storageSpaceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController monthlyRentController = TextEditingController();
  final TextEditingController securityDepositController =
      TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController secondaryNameController = TextEditingController();
  final TextEditingController secondaryphoneController =
      TextEditingController();
  final TextEditingController primaryphoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController accessCardController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Initialize controllers with form data values
    String firstName = widget.formData['first_name'] ?? '';
    String lastName = widget.formData['last_name'] ?? '';
    lesseeNameController.text =
        firstName + (lastName.isNotEmpty ? ' $lastName' : '');
    //secondary name
    String sfirstName = widget.formData['secondary_first_name'] ?? '';
    String slastName = widget.formData['secondary_last_name'] ?? '';
    secondaryNameController.text =
        sfirstName + (slastName.isNotEmpty ? ' $slastName' : '');
    storageSpaceController.text = widget.formData['space_number'] ?? '';
    unitController.text = widget.formData['unit_number'] ?? '';
    durationController.text = widget.formData['date_time'] ?? '';
    effectiveDateController.text = widget.formData['date_time'] ?? '';
    primaryphoneController.text = widget.formData['phone_number'] ?? '';
    secondaryphoneController.text = widget.formData['secondary_phone'] ?? '';
    emailController.text = widget.formData['primary_email'] ?? '';
    licenseController.text = widget.formData['license_plate'] ?? '';
    accessCardController.text = widget.formData['access_card'] ?? '';
  }

  //database helper
  final IndoorFormBackend _dbHelper = IndoorFormBackend();

// Update form data into the database
  void updateFormData() async {
    final effectiveDate = effectiveDateController.text;
    final lesseeName = lesseeNameController.text;
    final storageSpace = storageSpaceController.text;
    final duration = durationController.text;
    final monthlyRent = monthlyRentController.text;
    final securityDeposit = securityDepositController.text;
    final unitNumber = unitController.text;
    final secondaryName = secondaryNameController.text;
    final primphone = primaryphoneController.text;
    final secphone = secondaryphoneController.text;
    final email = emailController.text;
    final license = licenseController.text;
    final accessCard = accessCardController.text;

    Map<String, dynamic> formData = {
      'date_time': effectiveDate,
      'first_name': lesseeName.split(' ')[0],
      'last_name':
          lesseeName.split(' ').length > 1 ? lesseeName.split(' ')[1] : '',
      'space_number': storageSpace,
      'unit_number': unitNumber,
      'lease_duration': duration,
      'monthly_rent': monthlyRent,
      'security_deposit': securityDeposit,
      'secfirst_name': secondaryName.split(' ')[0],
      'seclast_name': secondaryName.split(' ').length > 1
          ? secondaryName.split(' ')[1]
          : '',
      'priphone': primphone,
      'secphone': secphone,
      'email': email,
      'license': license,
      'accessCard': accessCard,
    };
    // Save or update the form data in the database
    try {
      await _dbHelper.saveFormData(formData);
      debugPrint("Form data saved/updated successfully!");
    } catch (e) {
      debugPrint("Error saving/updating form data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: AppStyles.bodytext,
                  children: [
                    const TextSpan(
                      text:
                          'This storage space lease agreement (the “Lease”) is made between and entered into on ',
                      style: AppStyles.bodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          controller: effectiveDateController,
                          decoration: const InputDecoration(
                            hintText: "Effective Date",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' (the “Effective Date”) by and between Enterprise Park, Inc. of 23900 Outer Drive, Suite 1, Melvindale, Michigan 48122 (the “Lessor”) and ',
                      style: AppStyles.bodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          controller: lesseeNameController,
                          decoration: const InputDecoration(
                            hintText: "Lessee Name",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' (the “Lessee”), collectively referred to as the “Parties.”\n\nThe Parties hereby agree as follows: \n\n',
                      style: AppStyles.bodytext,
                    ),
                    const TextSpan(
                      text: 'TERMS AND CONDITIONS\n',
                      style: AppStyles.boldbodytext,
                    ),
                    TextSpan(
                      text: formattedDate,
                      style: AppStyles.boldbodytext,
                    ),
                    const TextSpan(
                      text: '\n\nTerm:',
                      style: AppStyles.bodytext,
                    ),
                    const TextSpan(
                      text:
                          '\nLessor hereby leases to Lessee the Storage Space ',
                      style: AppStyles.bodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          controller: storageSpaceController,
                          decoration: const InputDecoration(
                            hintText: "Storage Address",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' located at 23900 Outer Drive, Suite 1, Melvindale, Michigan 48122 (The “Premises”). The lease will start on ',
                      style: AppStyles.bodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 120,
                        child: TextField(
                          controller: durationController,
                          decoration: const InputDecoration(
                            hintText: "Lease Duration",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' and will continue as a month-month for indoor units or 6/12 month for outdoor spaces until such time as it is terminated by either party (with 30 day prior notice), the end of the contract date is reached or a violation.',
                      style: AppStyles.bodytext,
                    ),
                    const TextSpan(
                      text: '\n\nRent:',
                      style: AppStyles.bodytext,
                    ),
                    const TextSpan(
                      text: '\nOutdoor (Boat/RV/etc.) Lessee agrees to pay \$',
                      style: AppStyles.bodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 100,
                        child: TextField(
                          controller: monthlyRentController,
                          decoration: const InputDecoration(
                            hintText: "Monthly Rent",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' for 6 / 12 months. Indoor units and commercial pay \$',
                      style: AppStyles.bodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 100,
                        child: TextField(
                          controller: securityDepositController,
                          decoration: const InputDecoration(
                            hintText: "Security Deposit",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' per month. Lessor can pay by mail, over the phone or in person to Lessor. Space # ',
                      style: AppStyles.bodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          controller: storageSpaceController,
                          decoration: const InputDecoration(
                            hintText: "Security Deposit",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: ' or Unit # ',
                      style: AppStyles.bodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          controller: unitController,
                          decoration: const InputDecoration(
                            hintText: "Security Deposit",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: '\n\nSecurity Deposit:',
                      style: AppStyles.bodytext,
                    ),
                    const TextSpan(
                      text:
                          '\nLessee shall give the Lessor a security deposit of one month rent (indoor units only) as security for the performance by Lessee of the terms under this Lease and for any damages caused by the Lessee to the premises during the term of the lease. If no damages a full refund of the security deposit will be returned.',
                      style: AppStyles.bodytext,
                    ),
                    const TextSpan(
                      text: '\n\nAccess Cards:',
                      style: AppStyles.bodytext,
                    ),
                    const TextSpan(
                      text:
                          '\nNo sharing of access cards. The first access card has a \$50.00 deposit and upon return the \$50.00 will be refunded.For the second card a \$50.00 deposit with be charged and upon return a \$25.00 deposit will be refunded.IN WITNESS WHEREOF, this lease has been executed and delivered in the manner prescribed by law as of the Effective Date first written above.',
                      style: AppStyles.bodytext,
                    ),

                    //take contact information here
                    const TextSpan(
                      text: '\n\nCONTACT INFORMATION',
                      style: AppStyles.headingStyle,
                    ),
                    const TextSpan(
                      text: '\n\nSecondary Name: ',
                      style: AppStyles.boldbodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          controller: secondaryNameController,
                          decoration: const InputDecoration(
                            hintText: "Secondary Name",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: '\nPrimary Phone: ',
                      style: AppStyles.boldbodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          controller: primaryphoneController,
                          decoration: const InputDecoration(
                            hintText: "Primary Phone",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: '\nSecondary Phone: ',
                      style: AppStyles.boldbodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          controller: secondaryphoneController,
                          decoration: const InputDecoration(
                            hintText: "Secondary Phone",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: '\nEmail: ',
                      style: AppStyles.boldbodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: "Active Email",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: '\nLicense Plate: ',
                      style: AppStyles.boldbodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          controller: licenseController,
                          decoration: const InputDecoration(
                            hintText: "License Plate",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: '\nAccess Card: ',
                      style: AppStyles.boldbodytext,
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          controller: accessCardController,
                          decoration: const InputDecoration(
                            hintText: "Access Card",
                            hintStyle: AppStyles.bodytext1,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            border: UnderlineInputBorder(),
                          ),
                          style: AppStyles.boldbodytext,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              SizedBox(
                width: 260.0,
                height: 40.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Rounded boundaries
                          ),
                          child: Container(
                            width: 450,
                            height: 300,
                            padding: const EdgeInsets.all(25.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 229, 228, 228),
                              border: Border.all(
                                color: AppColors.textColor, // Blue border color
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white, // White background
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: AppColors
                                          .textColor, // Blue border color
                                      width: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Text on the left
                                    const Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Kindly provide your signature on the pad.",
                                            style: TextStyle(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontFamily: 'Inter'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    // Placeholder image on the right
                                    Expanded(
                                      flex: 3,
                                      child: Image.asset(
                                        'lib/assets/images/sign.png',
                                        fit: BoxFit.contain,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text(
                    "Click Here for Signature Pad",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text(
                    'By:____________________________________  Date:',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: durationController,
                      decoration: const InputDecoration(
                        hintText: "Lease Duration",
                        hintStyle: AppStyles.bodytext1,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        border: UnderlineInputBorder(),
                      ),
                      style: AppStyles.boldbodytext,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  const Text(
                    'By:____________________________________  Date:',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: durationController,
                      decoration: const InputDecoration(
                        hintText: "Lease Duration",
                        hintStyle: AppStyles.bodytext1,
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        border: UnderlineInputBorder(),
                      ),
                      style: AppStyles.boldbodytext,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Retake Button
                  SizedBox(
                    width: 140,
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            // Add border
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "BACK",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 70.0),

                  // Next Button
                  SizedBox(
                    width: 140,
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            // Add border
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        //move to next screen
                        // Access the values here
                        final effectiveDate = effectiveDateController.text;
                        final lesseeName = lesseeNameController.text;
                        final storageSpace = storageSpaceController.text;
                        final duration = durationController.text;
                        final monthlyRent = monthlyRentController.text;
                        final securityDeposit = securityDepositController.text;
                        final unitNumber = unitController.text;
                        final seclesseeName = secondaryNameController.text;
                        final primaryphone = primaryphoneController.text;
                        final secphone = secondaryphoneController.text;
                        final email = emailController.text;
                        final license = licenseController.text;
                        final accesscard = accessCardController.text;

                        // Debug prints for verification
                        debugPrint('Effective Date: $effectiveDate');
                        debugPrint('Lessee Name: $lesseeName');
                        debugPrint('Storage Address: $storageSpace');
                        debugPrint('Lease Duration: $duration');
                        debugPrint('Monthly Rent: $monthlyRent');
                        debugPrint('Security Deposit: $securityDeposit');
                        debugPrint('Unit Number: $unitNumber');
                        // Update database with form data
                        updateFormData();

                        // Prepare the data to pass to the PDF generator
                        final formData = {
                          'effective_date': effectiveDate,
                          'lessee_name': lesseeName,
                          'storage_address': storageSpace,
                          'duration': duration,
                          'monthly_rent': monthlyRent,
                          'security_deposit': securityDeposit,
                          'unit_number': unitNumber,
                          'seclesseeName': seclesseeName,
                          'primaryphone': primaryphone,
                          'secphone': secphone,
                          'email': email,
                          'license': license,
                          'accesscard': accesscard,
                        };
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FinishScreen(formData: formData),
                          ),
                        );
                      },
                      child: const Text(
                        "NEXT >>",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to free resources
    effectiveDateController.dispose();
    lesseeNameController.dispose();
    storageSpaceController.dispose();
    durationController.dispose();
    monthlyRentController.dispose();
    securityDepositController.dispose();
    unitController.dispose();
    super.dispose();
  }
}
