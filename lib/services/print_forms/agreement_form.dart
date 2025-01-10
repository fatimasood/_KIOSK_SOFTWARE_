import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class GeneratePdf {
  //custom page theme
  pw.PageTheme customPageTheme(PdfPageFormat format, pw.MemoryImage logo) {
    return pw.PageTheme(
      pageFormat: format,
      margin: pw.EdgeInsets.zero, // Remove all margins
      buildForeground: (context) => pw.Padding(
        padding: const pw.EdgeInsets.only(
            left: 50, top: 25.0, bottom: 0.0, right: 0.0),
        child: pw.Container(
          alignment: pw.Alignment.topLeft,
          child: pw.Image(logo, height: 100, width: 100),
        ),
      ),
      buildBackground: (context) => pw.Container(
        height: 10.0,
        alignment: pw.Alignment.bottomCenter,
        margin: const pw.EdgeInsets.only(
            top: 20.0, left: 20.0, right: 20.0, bottom: 40.0),
        child: pw.Text(
          'Enterprise Park, Inc. 23900 W. Outer Drive, Melvindale, MI 48122 (313) 383-7700',
          style: pw.TextStyle(
            fontSize: 8,
            color: PdfColors.grey500,
            font: pw.Font.helvetica(),
          ),
        ),
      ),
    );
  }

  // Function to create the PDF document
  Future<void> createLeaseAgreementPDF(Map<String, String> formData) async {
    final pdf = pw.Document();
// Load the logo image from assets
    final logoBytes = await rootBundle.load('lib/assets/images/logokiok.png');
    final logo = pw.MemoryImage(logoBytes.buffer.asUint8List());

    final titleStyle = pw.TextStyle(
      fontSize: 14,
      color: PdfColors.lightBlue700,
      font: pw.Font.helveticaBold(),
    );
    final headingStyle = pw.TextStyle(
      fontSize: 10,
      color: PdfColors.black,
      font: pw.Font.helveticaBold(),
      lineSpacing: 2.6,
    );

    final headingStyle1 = pw.TextStyle(
      fontSize: 9,
      color: PdfColors.black,
      font: pw.Font.helveticaBold(),
      lineSpacing: 2.6,
    );
    final normalStyle = pw.TextStyle(
      fontStyle: pw.FontStyle.normal,
      fontSize: 10,
      font: pw.Font.helvetica(),
      color: PdfColors.black,
      lineSpacing: 2,
    );

    final linktext = pw.TextStyle(
      fontStyle: pw.FontStyle.normal,
      fontSize: 10,
      font: pw.Font.helvetica(),
      color: PdfColors.green,
      lineSpacing: 2,
    );
    // Create a page
    pdf.addPage(
      pw.MultiPage(
        pageTheme: customPageTheme(PdfPageFormat.letter, logo),
        build: (context) => [
          pw.Padding(
            padding: const pw.EdgeInsets.only(
                bottom: 70.0, top: 90.0, left: 40.0, right: 40.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.RichText(
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        text:
                            'This storage space lease agreement (the "Lease") is made between and entered into on ${formData['effective_date']} (the "Effective Date") by and between Enterprise Park, Inc. of 23900 Outer Drive, Suite 1, Melvindale, Michigan 68122 (the "Lessor") and ${formData['lessee_name']} (the "Lessee") Collectively known as the "parties."',
                        style: normalStyle,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text("The Parties hereby agree as follows:",
                    style: normalStyle),
                pw.SizedBox(height: 10),
                pw.Text("TERMS AND CONDITIONS", style: headingStyle),
                pw.SizedBox(height: 10),
                pw.Text("Term:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  'Lessor hereby leases to Lessee the Storage Space ${formData['storage_address']} located at 23900 Outer Drive, Suite 1, Melvindale, Michigan 68122 (The "Premises"). The lease will start on ${formData['duration']} and will continue as a month-month for indoor units or 6/12 month for outdoor spaces until such time as it is terminated by either party (with 30 day prior notice), the end of the contract date is reached or a violation.',
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Rent:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  'Outdoor (Boat/RV/etc.) Lessee agrees to pay \$${formData['monthly_rent']} for 6 / 12 months. Indoor units and commercial pay \$${formData['security_deposit']} per month. Lessor can pay by mail, over the phone or in person to Lessor. Space # ${formData['storage_address']} or Unit #:${formData['unit_number']} ',
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Security Deposit:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  'Lessee shall give the Lessor a security deposit of one month rent (indoor units only) as security for the performance by Lessee of the terms under this Lease and for any damages caused by the Lessee to the premises during the term of the lease. If no damages a full refund of the security deposit will be returned.',
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Termination:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Either party may terminate this Lease by providing 30 day written notice to the other party.  Any such notice shall be directed to a party at the party's address. If violations to the rules and regulations is broke the (\"Lessor\") has the right to immediate termination and does not need to give 30 day written notice. For outdoor renters terminating before the end of their 6 month or 12 months lease no refund will be issued. For indoor spaces utilizing electricity; leaving lights on, radio on, fan/heater on or anything else plugged in when not occupied will result in termination of the lease and immediate eviction. Initial: _______",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Use of Indoor/Outdoor Premises:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Lessee will use the premises exclusively for the storage of Lessee's possessions. Lessee (indoor or outdoor) shall not use the premises for any illegal or otherwise prohibited activities. Lessee shall not keep or have on or around the premises any item of a dangerous, flammable, or explosive nature that might unreasonably increase the risk of fire, explosion on or around the premises, or that might be considered hazardous.  Lessee is strictly prohibited to sleep in a unit, RV, boat or item you have stored onsite.  Any violations to this can be grounds for immediate termination of the lease. Initial:_____________",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Default:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Any violation of this lease agreement will be viewed as a default.  If Lessee is in default, then Lessor at its sole discretion, terminate this lease, bring legal action for possession of abandoned property, or institute any other remedy as may be authorized either at law or in equity.  If you have multiple items stored here indoor/outdoor by defaulting on one you will need to remove all items.",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Public Restroom and Water Access:",
                    style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Lessee may have access to the public restroom and the water access via garden hose.  Lessee is responsible for the use of these facilities by their agents as well. Lessee is responsible for proper care and use.",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("RV/Boat/Trailer Washing:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Washing is only allowed at the dedicated wash bay along the building wall C1.  No washing is allowed at any other location.  No roof washing is permitted.  All activities performed at the facility is at your own risk. Enterprise Park, Inc. is held harmless",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                    "Disposition of Lessee's Personal Property on Eviction, Surrender, or Abandonment:",
                    style: headingStyle),
                pw.SizedBox(height: 6),
                pw.RichText(
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        text:
                            "The parties agree that on Lessee's surrender or abandonment of the Premises, or on termination of the agreement, Lessor shall not be liable or responsible for storage or disposition of Lessee's personal property remaining on the premises and may dispose of or take possession of such abandoned property. Any thing left after 60 days whether indoor or outside storage will be auctioned or towed off the premises after multiple attempts for payment or resolution. All attempts will be made to let Lessee know the auction house for indoor units ",
                        style: normalStyle,
                      ),
                      pw.TextSpan(
                        text: " (www.StorageAuctions.com) ",
                        style: linktext,
                      ),
                      pw.TextSpan(
                        text:
                            " and for outdoor no payment or abandon property will be towed by ",
                        style: normalStyle,
                      ),
                      pw.TextSpan(
                        text: " (www.StorageAuctions.com) ",
                        style: linktext,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text("Use of Exterior:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "This lease confers no rights on the Lessee to use, for any purpose, any portion of the Lessor's property other than the storage are leased, except the walkways and roadways giving access to and from Lessee's storage area or other areas of Lessor's property, if any, as Lessor may from time to time designate for the use of lessees.  When the use by Lessee of any other portion of Lessor's property is permitted, it shall be subject to the rules and regulations established by Lessor. Lessee does have access to the wash bay, firewood, ice, air, vacuum, fill water, dump station and any other amenities we offer.",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Security:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Enterprise Park has implemented many security features to make the property and customers safe.  When possible, we will investigate if an incident occurred but cannot guarantee a resolution. Enterprise Park, Inc. is held harmless for any damage that has occurred including, theft, vandalism or acts of God. ",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Liability:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Lessee's possessions will occupy the Premises entirely at the risk of the Lessee.  Lessor is not responsible for carrying any insurance covering Lessee's possessions. Lessee should, at his or her own expense, obtain insurance covering Lessee's possessions.  Lessee releases Lessor from any loss, damage, claim, or injury resulting from any casualty on the Premises. Lessee understands and agrees that the Lessee accepts full responsibility for any and all personal injuries or any other damages that may occur during use of the storage space, regardless of the reason. Further, Lessee agrees that Lessor, and all associated owners, agents, and employees, be held harmless for any and all injuries and damages occurring inside or outside of the Premises. Lessee further understands that Lessor is not responsible for other tenants who do not follow the terms of the lease agreement and injury, damage, or otherwise destroy the property or unit of Lessee.  In the event of loss and the loss is not the fault of Lessee, if possible, Lessor will transfer the Lessee to a new unit if the space is available.  No washing is allowed on the roof of RV's anywhere on the premises and anyone that climbs on the roof is responsible with Lessee being held harmless.",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 30.0),
                pw.Row(
                  children: [
                    pw.Text("Intitial:_____________________",
                        style: headingStyle1),
                    pw.Text(" Signature:_____________________",
                        style: headingStyle1),
                    pw.Text(" Date:${formData['effective_date']} ",
                        style: headingStyle1)
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text("Maintenance", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Lessee will, at Lessee's sole expense, keep and maintain the Premises in good, clean, and sanitary condition during the term of this Lease and any renewal thereof.  Lessee will promptly advise Lessor if the Premises are in need of any maintenance or repair. No ripped tarps or covers are allowed. Nothing to be stored behind their property including tires, ladders, golf carts, etc. ",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Leaving early:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Rent paid in advance by renter shall not be refunded to renter, and the last months hereunder shall not be prorated or refunded.  If 30 day notice is not given Lessor automatically will lose their security deposit.  ",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Use of Dumpster: ", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Individual garbage cans throughout the facility are available for renters indoor and outdoor to dispose small items. Access to the larger dumpster is strictly prohibited and large amounts of trash need to be taken off site and disposed of. If found guilty of violating this immediate termination will occur.",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Assignment and Sublease: ", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Lessee shall not assign or sublease any interest in the lease.",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Renting your RV/Boat/Trailer: ", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "If you plan to rent your stored items to an outside party the transaction should occur off premises. No sharing of access cards or code is allowed.",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Renting your RV/Boat/Trailer: ", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "If you plan to rent your stored items to an outside party the transaction should occur off premises. No sharing of access cards or code is allowed.",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Non-Payment: ", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "Every effort will be made to get payment current.  After 60 days of nonpayment for exterior spaces Goch & Sons our official tow company will remove your property. For indoor units after nonpayment remaining items will be auctioned via StorageTreasures.com  ",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Governing Law: ", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "This lease shall be governed by the laws of the State of Michigan. Either city of Melvindale or City of Allen Park courts will be involved for indoor units and outdoor space evictions. ",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Entire Agreement:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "This lease contains the entire agreement of the parties, and there are no other promises or conditions in any other agreement whether oral or written concerning the subject matter of this Lease.  This lease supersedes any prior written or oral agreements between the parties",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Severability:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "If any provisions of the lease will be held invalid or unenforceable for any reason, the remaining provisions will continue to be valid and enforceable. If a court finds that any provisions of this Lease is invalid or unenforceable, but that by limiting such provision it would become valid and enforceable, then such provisions will be deemed to be written, construed, and enforced as so limited. ",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Amendments:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "This Lease may be modified or amended in writing, if the writing is signed by the parity obligated under the modification or amendment. The signature must be a live ink signature in person. ",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Waiver of Contractual Rights:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "The failure of either party to enforce a provision of this Lease shall not be construed as a waiver or limitations of that party's right to subsequently enforce and compel strict compliance with every provision of this Lease. ",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 8),
                pw.Text("Access Cards:", style: headingStyle),
                pw.SizedBox(height: 6),
                pw.Text(
                  "No sharing of access cards. The first access card has a \$50.00 deposit and upon return the \$50.00 will be refunded. For the second card a \$50.00 deposit with be charged and upon return a \$25.00 deposit will be refunded. ",
                  style: normalStyle,
                ),
                pw.SizedBox(height: 12),
                pw.Text(
                    "IN WITNESS WHEREOF, this lease has been executed and delivered in the manner prescribed by law as of the Effective Date first written above.",
                    style: headingStyle1),
                pw.SizedBox(height: 12),
                pw.Text("LESSOR:", style: headingStyle),
                pw.SizedBox(height: 20),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("BY: ", style: headingStyle1),
                    pw.Text(
                      "_________________________",
                      style: headingStyle1,
                    ),
                    pw.SizedBox(width: 25.0),
                    pw.Text("Date: ", style: headingStyle1),
                    pw.Text(
                      "${formData['effective_date']} ",
                      style: headingStyle1,
                    ),
                  ],
                ),
                pw.SizedBox(height: 30.0),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("BY: ", style: headingStyle1),
                    pw.Text(
                      "_________________________",
                      style: headingStyle1,
                    ),
                    pw.SizedBox(width: 25.0),
                    pw.Text("Date: ", style: headingStyle1),
                    pw.Text(
                      "${formData['effective_date']} ",
                      style: headingStyle1,
                    ),
                  ],
                ),
                pw.SizedBox(height: 12),
                pw.Text("LESSEE:", style: headingStyle),
                pw.SizedBox(height: 25.0),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("BY: ", style: headingStyle1),
                    pw.Column(
                      children: [
                        pw.Text(
                          "_________________________",
                          style: headingStyle1,
                        ),
                        pw.Text(
                          " Agent for Enterprise Park, Inc.",
                          style: pw.TextStyle(
                            fontSize: 7,
                            color: PdfColors.black,
                            font: pw.Font.helveticaBold(),
                            lineSpacing: 2.6,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(width: 25.0),
                    pw.Text("Date: ", style: headingStyle1),
                    pw.Text(
                      "${formData['effective_date']} ",
                      style: headingStyle1,
                    ),
                  ],
                ),
                pw.SizedBox(height: 15.0),
                pw.Text("CONTACT INFORMATION: ", style: titleStyle),
                pw.SizedBox(height: 25.0),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text("Primary Name: ", style: headingStyle1),
                        pw.SizedBox(width: 5.0),
                        pw.Text("${formData['lessee_name']}",
                            style: normalStyle),
                      ],
                    ),
                    pw.SizedBox(width: 35.0),
                    pw.Row(
                      children: [
                        pw.Text("Secondary Name: ", style: headingStyle1),
                        pw.SizedBox(width: 5.0),
                        pw.Text("${formData['seclesseeName']} ",
                            style: normalStyle),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 25.0),
                pw.Row(
                  children: [
                    pw.Text("Primary Phone: ", style: headingStyle1),
                    pw.SizedBox(width: 5.0),
                    pw.Text("${formData['primaryphone']} ", style: normalStyle),
                  ],
                ),
                pw.SizedBox(height: 25.0),
                pw.Row(
                  children: [
                    pw.Text("Secondary Phone: ", style: headingStyle1),
                    pw.SizedBox(width: 5.0),
                    pw.Text("${formData['secphone']} ", style: normalStyle),
                  ],
                ),
                pw.SizedBox(height: 25.0),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text("Email: ", style: headingStyle1),
                        pw.SizedBox(width: 5.0),
                        pw.Text("${formData['email']} ", style: normalStyle),
                      ],
                    ),
                    pw.SizedBox(width: 25.0),
                    pw.Row(
                      children: [
                        pw.Container(
                          width: 8,
                          height: 8,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 5.0),
                        pw.Text("Opt in for newsletter email ",
                            style: headingStyle1),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 25.0),
                pw.Row(
                  children: [
                    pw.Text("Space# (Indoor or Outdoor): ",
                        style: headingStyle1),
                    pw.SizedBox(width: 5.0),
                    pw.Text("${formData['storage_address']} ",
                        style: normalStyle),
                  ],
                ),
                pw.SizedBox(height: 25.0),
                pw.Text(
                  "Description of vehicle/RV/Boat/Trailer, etc. (Outdoor only):",
                  style: headingStyle1,
                ),
                pw.SizedBox(height: 25.0),
                pw.Text(
                  "_______________________________________________",
                  style: headingStyle1,
                ),
                pw.SizedBox(height: 25.0),
                pw.Text(
                  "Year/Make/Model (Outdoor only): ",
                  style: headingStyle1,
                ),
                pw.SizedBox(height: 25.0),
                pw.Text(
                  "Year: __________________ ",
                  style: headingStyle1,
                ),
                pw.SizedBox(height: 25.0),
                pw.Text(
                  "Make: __________________ ",
                  style: headingStyle1,
                ),
                pw.SizedBox(height: 25.0),
                pw.Text(
                  "Model: __________________ ",
                  style: headingStyle1,
                ),
                pw.SizedBox(height: 25.0),
                pw.Row(
                  children: [
                    pw.Text("License Plate#: ", style: headingStyle1),
                    pw.SizedBox(width: 5.0),
                    pw.Text("${formData['license']} ", style: normalStyle),
                  ],
                ),
                pw.SizedBox(height: 25.0),
                pw.Text(
                  "Copy of Driver's License & Registration (check if both are provided) ",
                  style: headingStyle1,
                ),
                pw.SizedBox(height: 25.0),
                pw.Row(
                  children: [
                    pw.Text("Access Card #1: ", style: headingStyle1),
                    pw.SizedBox(width: 5.0),
                    pw.Text("${formData['accesscard']} ", style: normalStyle),
                    pw.Text(
                      "(\$50.00 key deposit refundable if returned) ",
                      style: headingStyle1,
                    ),
                  ],
                ),
                pw.SizedBox(height: 25.0),
                pw.Text(
                  "Access Card #2(Optional):_________________________________ (\$50.00 key deposit 25.00 refundable if returned)  ",
                  style: headingStyle1,
                ),
                pw.SizedBox(height: 10.0),
                pw.Row(
                  children: [
                    pw.Text(
                      "***",
                      style: pw.TextStyle(
                          color: PdfColors.red,
                          fontSize: 10.0,
                          fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      "\$50.00 replacement key",
                      style: headingStyle1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // Save the PDF to a temporary file
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/lease_agreement.pdf');
    await file.writeAsBytes(await pdf.save());

    // Optionally, open the file for preview or download
    OpenFile.open(file.path);

    // Optionally, trigger print action
    Printing.layoutPdf(onLayout: (format) => pdf.save());
  }
}
