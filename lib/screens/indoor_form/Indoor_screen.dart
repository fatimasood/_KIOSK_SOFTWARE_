import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../assets/core/app_colors.dart';
import '../../assets/core/app_style.dart';
import '../../database/indoor_data.dart';
import '../../widgets/scan_card.dart';
import '../agreements/rules.dart';

class Indoorform extends StatefulWidget {
  const Indoorform({super.key});

  @override
  State<Indoorform> createState() => _IndoorformState();
}

class _IndoorformState extends State<Indoorform> {
  bool _isSubscribed = true;
  //bool _isScanned = false;
  final _formKey = GlobalKey<FormState>();
  final IndoorFormBackend _backend = IndoorFormBackend();

// Collect user input
  final Map<String, dynamic> _formData = {};
  @override
  void initState() {
    super.initState();
    _backend.initDatabase(); // Initialize database
  }

// check id scanned or not
  void _onIDScanned() {
    setState(() {
      //  _isScanned = true; // Mark as scanned
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Contact Form",
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor,
                          ),
                        ),
                        const SizedBox(
                          width: 205,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                                  const Color(0xFF0072CE), // Blue Border Color
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$50.00 Access Card Deposit",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0072CE),
                                ),
                              ),
                              SizedBox(height: 4), // Spacing
                              Text(
                                "\$50.00 Replacement Card if Lost",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0072CE),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Two-Column Layout
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column
                      Expanded(
                        child: Column(
                          children: [
                            _buildInputField("First Name", "first_name"),
                            _buildInputField(
                                "Secondary First Name", "secondary_first_name"),
                            _buildInputField("Primary Email", "primary_email"),
                            _buildInputField("Phone number", "phone_number"),
                            _buildInputField("Unit Number", "unit_number"),
                            _buildInputField("Space #", "space_number"),
                            _buildInputField("License Plate # (if applicable)",
                                "license_plate"),
                            _buildInputField("Access Card #", "access_card"),
                          ],
                        ),
                      ),

                      const SizedBox(width: 40), // Spacer between columns

                      // Right Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputField("Last Name", "last_name"),
                            _buildInputField(
                                "Secondary Last Name", "secondary_last_name"),
                            _buildInputField(
                                "Secondary Email", "secondary_email"),
                            _buildInputField(
                                "Secondary Phone", "secondary_phone"),

                            // Newsletter Toggle
                            _buildNewsletterToggle(),

                            // Scan Button
                            _buildButton(
                              "Click here to Scan ID",
                              ScanCard(
                                onScanned: _onIDScanned,
                              ),
                            ),

                            // Description
                            _buildTextArea(
                                "Description of items being stored Indoors"),

                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: 230,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0), // Rounded boundaries
                                        ),
                                        child: Container(
                                          width: 345.0,
                                          height: 180.0,
                                          padding: const EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            color: AppColors.backgroundColor,
                                            border: Border.all(
                                              color: AppColors
                                                  .textColor, // Blue border color
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Column(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(20.0),
                                                child: Text(
                                                  "Hey....!! Have you scanned your ID?",
                                                  style: AppStyles.boldbodytext,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 85.0,
                                                    height: 35,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors
                                                                .primaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "NO", //
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 85.0,
                                                    height: 35,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors
                                                                .primaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        //all next part

                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          //save data
                                                          _formKey.currentState!
                                                              .save();

                                                          try {
                                                            //get current date and time

                                                            String
                                                                currentDateTime =
                                                                DateFormat(
                                                                        'dd/MM/yyyy')
                                                                    .format(DateTime
                                                                        .now());
                                                            _formData[
                                                                    'date_time'] =
                                                                currentDateTime;
                                                            await _backend
                                                                .saveFormData(
                                                              {
                                                                'first_name':
                                                                    _formData[
                                                                        'first_name'],
                                                                'last_name':
                                                                    _formData[
                                                                        'last_name'],
                                                                'primary_email':
                                                                    _formData[
                                                                        'primary_email'],
                                                                'phone_number':
                                                                    _formData[
                                                                        'phone_number'],
                                                                'unit_number':
                                                                    _formData[
                                                                        'unit_number'],
                                                                'space_number':
                                                                    _formData[
                                                                        'space_number'],
                                                                'license_plate':
                                                                    _formData[
                                                                        'license_plate'],
                                                                'access_card':
                                                                    _formData[
                                                                        'access_card'],
                                                                'secondary_first_name':
                                                                    _formData[
                                                                        'secondary_first_name'],
                                                                'secondary_last_name':
                                                                    _formData[
                                                                        'secondary_last_name'],
                                                                'secondary_email':
                                                                    _formData[
                                                                        'secondary_email'],
                                                                'secondary_phone':
                                                                    _formData[
                                                                        'secondary_phone'],
                                                                'description':
                                                                    _formData[
                                                                        'description'],
                                                                'date_time':
                                                                    currentDateTime,
                                                                'is_subscribed':
                                                                    _isSubscribed
                                                                        ? 1
                                                                        : 0,
                                                              },
                                                            );
                                                          } catch (error) {
                                                            if (kDebugMode) {
                                                              print(
                                                                  'Error saving form: $error');
                                                            }
                                                          }
                                                        } else {
                                                          // Show error if validation fails
                                                          if (kDebugMode) {
                                                            print(
                                                                'Validation failed!');
                                                          }
                                                        }
                                                        Navigator.push(
                                                          // ignore: use_build_context_synchronously
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                LeaseAgreementScreen(
                                                              formData:
                                                                  _formData,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text(
                                                        "YES", //scnned
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
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
                                  "Next >>",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Input Field Widget
  Widget _buildInputField(String label, String key) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 13, color: Colors.black)),
          const SizedBox(height: 4),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.greyBorder, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            onSaved: (value) {
              _formData[key] = value;
            },
          ),
        ],
      ),
    );
  }

  // Newsletter Toggle Widget
  Widget _buildNewsletterToggle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        children: [
          const Text("Newsletter", style: TextStyle(fontSize: 13)),
          const SizedBox(width: 10),
          Switch(
            value: _isSubscribed,
            onChanged: (bool value) {
              setState(() {
                _isSubscribed = value;
              });
            },
            activeColor: AppColors.textColor,
          ),
        ],
      ),
    );
  }

  // Custom Button Widget
  Widget _buildButton(String text, Widget screen) {
    return SizedBox(
      width: 230.0,
      height: 40.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.lightText),
        ),
      ),
    );
  }

  // Multi-Line Text Area
  Widget _buildTextArea(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 13, color: Colors.black)),
          const SizedBox(height: 6),
          TextFormField(
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
