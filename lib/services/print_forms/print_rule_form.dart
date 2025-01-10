import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class GeneratePdfDoc {
  // Function to create the PDF document
  Future<void> createLeaseAgreementPDF(Map<String, String> formData) async {
    final pdf = pw.Document();
// Load the logo image from assets
    final logoBytes = await rootBundle.load('lib/assets/images/logokiok.png');
    final logo = pw.MemoryImage(logoBytes.buffer.asUint8List());

    // Define text styles
    final titleStyle = pw.TextStyle(
      fontSize: 10,
      letterSpacing: 2,
      color: PdfColors.lightBlue700,
      font: pw.Font.helveticaBold(),
    );
    final headingStyle = pw.TextStyle(
      fontSize: 7,
      color: PdfColors.black,
      font: pw.Font.helveticaBold(),
      lineSpacing: 2.5,
    );
    final headingitalic = pw.TextStyle(
      fontSize: 7,
      color: PdfColors.black,
      font: pw.Font.helveticaBoldOblique(),
      lineSpacing: 2.5,
    );
    final headingStyle1 = pw.TextStyle(
      fontSize: 8,
      color: PdfColors.black,
      font: pw.Font.helveticaBold(),
      lineSpacing: 2.5,
    );
    final normalStyle = pw.TextStyle(
      fontStyle: pw.FontStyle.normal,
      fontSize: 7,
      font: pw.Font.helvetica(),
      color: PdfColors.black,
      lineSpacing: 2,
    );

    // Create a page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(15.0),
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.only(
                top: 25.0, left: 25.0, right: 25.0, bottom: 15.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Saving you time and money!",
                  style: titleStyle,
                ),
                pw.SizedBox(height: 8.0),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 40.0),
                    pw.Image(logo, width: 70, height: 70),
                    pw.SizedBox(width: 150.0),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Internet", style: headingStyle),
                        pw.Text("Email: info@ENTPARK.com", style: normalStyle),
                        pw.Row(
                          children: [
                            pw.Text("Website: ", style: normalStyle),
                            pw.Text(
                              "www.ENTPARK.com",
                              style: pw.TextStyle(
                                fontSize: 7,
                                font: pw.Font.helvetica(),
                                fontWeight: pw.FontWeight.normal,
                                color: PdfColors.blueAccent700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                pw.Divider(thickness: 1.0),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "OFFICE HOURS",
                          style: headingStyle,
                        ),
                        pw.Text("Saturday and Sunday", style: normalStyle),
                        pw.Text("10 a.m. to 4 p.m.", style: normalStyle),
                      ],
                    ),
                    pw.Container(
                      height: 30.0,
                      width: 1.0,
                      color: PdfColors.black,
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "GATE ACCESS",
                          style: headingStyle,
                        ),
                        pw.Text(
                          "24 hours/day",
                          style: normalStyle,
                        ),
                        pw.Text(
                          "7 days/week",
                          style: normalStyle,
                        ),
                      ],
                    ),
                    pw.Container(
                      height: 30.0,
                      width: 1,
                      color: PdfColors.black,
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "LATE FEES",
                          style: headingStyle,
                        ),
                        pw.Text(
                          "Calculated following tenant's anniversary billing date.",
                          style: normalStyle,
                        ),
                        pw.Text(
                          "If payment received after 5th day... \$10.00 Late Fee",
                          style: normalStyle,
                        ),
                        pw.Text(
                          "If payment received after 15th day... \$20.00 Preliminary Lien Notice Fee",
                          style: normalStyle,
                        ),
                        pw.Text(
                          "If payment received after 36th day... \$30.00 Lien / Foreclosure Filing Fee",
                          style: normalStyle,
                        ),
                        pw.Text(
                          "No payment by 60 days auction/towing will take place",
                          style: normalStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                pw.Divider(thickness: 1.0),
                pw.SizedBox(height: 4.0),
                pw.Row(
                  children: [
                    pw.Text("Space# ", style: headingStyle1),
                    pw.Text(
                      "${formData['storage_address']} ",
                      style: normalStyle,
                    ),
                    pw.Text(" Unit# ", style: headingStyle1),
                    pw.Text(
                      "${formData['unit_number']} ",
                      style: normalStyle,
                    ),
                  ],
                ),
                pw.SizedBox(height: 8.0),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text: "PAYMENT OPTIONS ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "Cash, Check, Money Order, Visa, Mastercard, American Express, Discover; make payable to: Enterprise Park, Inc.; include unit or outside space number on check/money order. If mailing payment send to: Enterprise Park, Inc. 23900 Outer Drive, Suite 1, Melvindale, MI 48122. ",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text:
                                  "INVOICES ARE NOT MAILED. NO INVOICES WILL BE SENT. ",
                              style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "Payment is sole responsibility of tenant and is expected to be received on applicable due date. Payments received after 5:00 p.m. will be credited on next business day. Please note: if payment has not been received by the due date, ",
                              style: normalStyle),
                          pw.TextSpan(
                              text:
                                  "GATE ACCESS WILL BE DENIED AUTOMATICALLY AND LATE FEES WILL BE INCURRED. Delinquent vehicle accounts are subject to towing. Towed vehicles will be impounded and retrieval will be sole responsibility of vehicle owner. ",
                              style: headingitalic),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(text: "PRORATING ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "There is no prorating of rent and no rent refunds for partial months on early departures. All rentals of units and/or vehicle space is for a minimum of one month. All Rental Fees are payable in advance. ",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text: "TENANT ADDRESS/PHONE CHANGES ",
                              style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "Tenant is required to report all address, email and phone number changes in writing within 10 days of change. Forms are available both online and at the facility to be placed in Drop Box. It is tenant's sole responsibility to notify Enterprise Park, Inc. of all changes. ",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(text: "LOCK USAGE ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "ONE LOCK PER UNIT is permitted. Tenant's lock must be on unit within 24 hours after rental and must remain locked at all times that door is closed. Units without locks will be assumed abandoned and/or vacated. At no time are bolt cutters or electric saws for removing locks or any other types of equipment permitted on premises. ",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text: "VACATING UNIT ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "When planning to vacate unit, a 30 day written notice is required. Forms are available online, at the office, or in the drop-box between the mailboxes. Forms may be placed in Drop-box, emailed or U.S. mailed. Tenant is required to remove all belongings, sweep-clean unit, close door and remove lock. Failure to remove lock will result in tenant's being charged for the next month's full rent and all applicable late fees.",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text: "ABANDONMENT OF SPACE ",
                              style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "The attached Agreement shall automatically terminate if Occupant abandons the Space. Tenant shall have abandoned the Space if Tenant has removed the contents of the space, and/or has removed Tenant's locking device from the space and IS NOT current in all obligations.",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 10.0),
                    pw.Text(
                        textAlign: pw.TextAlign.start,
                        "RULES AND REGULATIONS",
                        style: headingStyle1),
                    pw.SizedBox(height: 10.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text: "INSURANCE OF STORED GOODS ",
                              style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "Facility Owner does not insure tenants' goods or vehicles. INSURANCE IS SOLE RESPONSIBILITY OF TENANT.",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(text: "LIABILITY ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "Darragh Storage, Inc. dBA Enterprise Park, Inc. is held harmless from an injury, death, act of God on all parcels and property associated with the facility Initials",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text: "SPEED LIMIT ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  " Facility speed limit is 10 MPH. except for bridge crossing which is 5 MPH No careless or reckless driving is permitted on premises",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(text: "SECURITY ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "Facility entry and exit is by proximity card only. Gate access is exclusively for Tenant's use. When entering or exiting gate, do not TAILGATE. Wait for previous tenant if necessary, then present the card for entry. No sharing of your access card ",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text: "TENANTS GUESTS ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "Tenants' visitors and guests are to be accompanied by tenant at all times and are tenants' responsibility which includes proper entry and exit of premises and proper care of facility property. Children are to remain with, and be supervised by parents at all times. Pets must be leashed and cleaned up after. ",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text: "SMOKING & DRINKING ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "Smoking is prohibited in units. Drinking of Alcoholic Beverages is prohibited on all premises. ",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text: "HAZARDOUS MATERIALS ",
                              style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "Storing of gas cans or any other flammable or hazardous materials is strictly prohibited. All laws governing handling of hazardous materials are to be strictly complied with.",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(text: "PREMISES ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "No garage sales or yard sales are permitted on the premises. No use of electricity for indoor units when not occupied. Includes radio, fan/heater, lights, etc. Grounds for immediate eviction. ",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text: "OPEN STORAGE ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "No open storage of vehicles, boats, trailers, etc. is permitted except on a space rental basis under prior arrangement and lease agreement with facility management. Unattended, unlicensed, unregistered or unknown vehicles or loose, unsecured items may be towed and/or removed at tenants' expense and without notice. It is imperative you check on your personal property and maintain the appearance ",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(text: "DUMPSTER ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "Use of Dumpster is for BAGGED TRASH ONLY.in the designated gray garbage cans. Tenant will be charged for any use of main 6 yard dumpster for NON-BAGGED trash as well as for any clean-up associated with items left by Tenant on premises or in unit. ",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5.0),
                    pw.RichText(
                      text: pw.TextSpan(
                        children: [
                          pw.TextSpan(
                              text: "VEHICLE STORAGE ", style: headingStyle),
                          pw.TextSpan(
                              text:
                                  "All non-motorized vehicles are required to have a minimum of two (2) wheel chocks surrounding vehicle wheels at all times while stored in facility.",
                              style: normalStyle),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 10.0),
                    pw.Text("ACKNOWLEDGEMENT", style: headingStyle1),
                    pw.SizedBox(height: 5.0),
                    pw.Text(
                        "I have read, fully understand and agree to comply with these Rules and Regulations. I also understand that this form is a legal and binding part of my entire lease agreement.",
                        style: normalStyle),
                    pw.SizedBox(height: 30.0),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("TENANT SIGNATURE: ", style: headingStyle),
                        pw.Text(
                          "_________________________",
                          style: normalStyle,
                        ),
                        pw.SizedBox(width: 20.0),
                        pw.Text("Date: ", style: headingStyle),
                        pw.Text(
                          "${formData['effective_date']} ",
                          style: normalStyle,
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 20.0),
                    pw.Center(
                      child: pw.Text(
                          textAlign: pw.TextAlign.end,
                          "Enterprise Park, Inc., 23900 Outer Drive, Suite 1, Melvindale, MI 48122 ",
                          style: headingStyle),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
    // Save the PDF to a temporary file
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/rules_agreement.pdf');
    await file.writeAsBytes(await pdf.save());

    // Optionally, open the file for preview or download
    OpenFile.open(file.path);

    // Optionally, trigger print action
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
