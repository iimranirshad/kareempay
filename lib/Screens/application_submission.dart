import 'dart:io';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:open_file/open_file.dart';

import '../Constants/constants.dart';
import 'home_screen.dart';

class ApplicationSubmission extends StatefulWidget {
  final int? prediction;
  const ApplicationSubmission({super.key, required this.prediction});

  @override
  State<ApplicationSubmission> createState() => _ApplicationSubmissionState();
}

class _ApplicationSubmissionState extends State<ApplicationSubmission> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  bool showContinueButton = false;
  int repayment = 0;
  @override
  void initState() {
    super.initState();
    if (widget.prediction == 0) {
      fetchUserData();
    } else {
      isLoading = false;
      proceedAfterDelay();
    }
  }

  Future<void> fetchUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid; // Replace with dynamic UID
      final doc = await FirebaseFirestore.instance.collection('applications').doc(uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
          isLoading = false;
        });
        await Future.delayed(Duration(seconds: 1));
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> proceedAfterDelay() async {
    await Future.delayed(Duration(seconds: 3));
    navigateToHome();
  }

  Future<void> generateAndSaveInvoice(Map<String, dynamic> data) async {
    final pdf = pw.Document();
    final now = DateTime.now();
    final invoiceName = 'invoice_${now.millisecondsSinceEpoch}.pdf';
    double amount = double.tryParse(data['amount'].toString()) ?? 0.0;
    double time = double.tryParse(data['timeforloan'].toString()) ?? 0.0;
    repayment = (amount / time).toInt();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Container(
          height: double.infinity,
          width: double.infinity,
          color: PdfColors.green,
          child: pw.Padding(padding: pw.EdgeInsets.symmetric(horizontal: 3),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Center(
                  child: pw.Container(
                    width: double.infinity,
                    color: PdfColors.green,
                    child: pw.Center(
                        child: pw.Text("Loan Application Invoice", style: pw.TextStyle(fontSize: 28,color: PdfColors.black))
                    ),
                  )
              )
              ,
              pw.SizedBox(height: 20),
              pw.Container(
                width: double.infinity,
                color: PdfColors.green100,
                child: pw.Text("Invoice ID: INV-${now.millisecondsSinceEpoch}",style: pw.TextStyle(color: PdfColors.black,fontSize: 16)),
              ),
              pw.SizedBox(height: 1.h),
              pw.Container(
                width: double.infinity,
                color: PdfColors.green,
                child: pw.Text("Full Name: ${data['fullName']}",style: pw.TextStyle(color: PdfColors.white)),
              ),
              pw.SizedBox(height: 1.h),
              if(data['item'] != null)...[
                pw.Container(
                  width: double.infinity,
                  color: PdfColors.white,
                  child: pw.Text("Item: ${data['item']}",style: pw.TextStyle(color: PdfColors.green)),
                ),
              ],
              if(data['asset'] != null)...[
                pw.Container(
                  width: double.infinity,
                  color: PdfColors.white,
                  child: pw.Text("Asset to Lease: ${data['asset']}",style: pw.TextStyle(color: PdfColors.green)),
                ),
                pw.SizedBox(height: 1.h),
              ],
              pw.Container(
                width: double.infinity,
                color: PdfColors.green,
                child: pw.Text("Amount: \$${data['amount']}",style: pw.TextStyle(color: PdfColors.white)),
              ),
              pw.SizedBox(height: 1.h),
              pw.Container(
                width: double.infinity,
                color: PdfColors.white,
                child: pw.Text('Loan Time: ${data['timeforloan']}',style: pw.TextStyle(color: PdfColors.green)),
              ),
              pw.SizedBox(height: 1.h),
              pw.Container(
                width: double.infinity,
                color: PdfColors.green,
                child: pw.Text('Repayment: \$${repayment.toString()} per month',style: pw.TextStyle(color: PdfColors.white)),
              ),
              pw.SizedBox(height: 1.h),
              pw.Container(
                width: double.infinity,
                color: PdfColors.white,
                child: pw.Text("Date: ${now.toLocal().toString().split(' ')[0]}",style: pw.TextStyle(color: PdfColors.green)),
              ),
            ],
          ),)
        )
      ),
    );

    // Request permission
    final permission = await Permission.manageExternalStorage.request();
    if (permission.isGranted || await Permission.storage.request().isGranted) {
      final dirList = await getExternalStorageDirectories(type: StorageDirectory.downloads);
      final dir = dirList?.first;
      if (dir != null) {
        final filePath = '${dir.path}/$invoiceName';
        final file = File(filePath);
        await file.writeAsBytes(await pdf.save());
        print('Invoice saved at: $filePath');

        await OpenFile.open(filePath);
        setState(() {
          showContinueButton = true;
        });
      } else {
        print('Download directory not found');
      }
    } else {
      print('Permission denied to write to storage');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Storage permission is required to save the invoice.")),
      );
      if (await Permission.storage.isPermanentlyDenied) {
        openAppSettings(); // Prompt user to enable permission manually
      }
    }
  }

  void navigateToHome() {
    Navigator.push(
      context,
      PageTransition(type: PageTransitionType.fade, child: HomeScreen(flag: false)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : widget.prediction == 0?Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProfileAvatar(
              '',
              backgroundColor: primary,
              borderWidth: 1.5.h,
              borderColor: secondary,
              radius: 10.h,
              cacheImage: true,
              onTap: () {},
              animateFromOldImageOnUrlChange: true,
              placeHolder: (context, url) => Center(child: CircularProgressIndicator()),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: Text(
                'Loan Application Has Been Successfully Submitted',
                style: GoogleFonts.poppins(
                  fontSize: 24.sp,
                  color: secondary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (showContinueButton) ...[
              SizedBox(height: 4.h),
              ElevatedButton(
                onPressed: navigateToHome,
                child: Text("Continue"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondary,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                  textStyle: TextStyle(fontSize: 12.sp),
                ),
              ),
            ]
          ],
        ):Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProfileAvatar(
              '',
              backgroundColor: primary,
              borderWidth: 1.5.h,
              borderColor: secondary,
              radius: 10.h,
              cacheImage: true,
              onTap: () {},
              animateFromOldImageOnUrlChange: true,
              placeHolder: (context, url) => Center(child: CircularProgressIndicator()),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: Text(
                'Loan Application was disapproved',
                style: GoogleFonts.poppins(
                  fontSize: 24.sp,
                  color: secondary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
