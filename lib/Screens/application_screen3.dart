import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Constants/constants.dart';
import 'package:karim_pay/Screens/application_submission.dart';
import 'package:karim_pay/Screens/home_screen.dart';
import 'package:karim_pay/Widgets/application_fields.dart';
import 'package:karim_pay/Widgets/custom_check_box.dart';
import 'package:karim_pay/Widgets/files_card.dart';

import 'package:karim_pay/Widgets/sub_headings.dart';
import 'package:karim_pay/Widgets/user_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'dart:typed_data';

import '../Widgets/credit_score.dart';
import '../Widgets/menu_textfield.dart';
import 'edit_profile.dart';
import 'notification_screen.dart';

class ApplicationScreen3 extends StatefulWidget {
  const ApplicationScreen3({super.key});

  @override
  State<ApplicationScreen3> createState() => _ApplicationScreen3State();
}

class _ApplicationScreen3State extends State<ApplicationScreen3> {
  String? _status;
  Uint8List? _imageBytes;
  int? prediction = 0;
  String _subtitle = 'Upload File';
  String _subtitle2 = 'Upload File';
  String _subtitle3 = 'Upload File';
  String _subtitle4 = 'Upload File';
  String _subtitle5 = 'Upload File';
  String _subtitle6 = 'Upload File';
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  File? _file1;
  File? _file2;
  File? _file3;
  File? _file4;
  File? _file5;
  File? _file6;

  bool? file_1 = false;
  bool? file_2 = false;
  bool? file_3 = false;
  bool? file_4 = false;
  bool? file_5 = false;
  bool? file_6 = false;

  bool _acceptCondition = false;
  final TextEditingController _homeTypeController = TextEditingController();
  final TextEditingController _empLengthController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _loanController = TextEditingController();
  final TextEditingController _assetlease = TextEditingController();
  final TextEditingController _leaseduration = TextEditingController();
  final TextEditingController _loanTime = TextEditingController();

  final List<String> _homeTypes = ['OWN', 'RENT', 'MORTGAGE'];
  final List<String> _availingLoan = [
    'Y',
    'N',
  ];
  final List<String> _empLength = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  String _selectedEmpLength = '1';
  String _selectedHomeType = 'OWN';
  String _selectedLoan = 'Y';
  Future<String?> _encodeFileToBase64(File? file) async {
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  void _submitApplication() async {
    final apiUrl = Uri.parse("http://10.1.29.60:5000/predict");
    final apiUrl2 = Uri.parse("http://10.1.29.60:5000/predict_nlp");
    final apiUrl3 = Uri.parse("http://10.1.29.60:5000/verify_cnic");

    //validation
    if (_fullNameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _incomeController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _purposeController.text.isEmpty ||
        _loanTime.text.isEmpty ||
        _assetlease.text.isEmpty ||
        _leaseduration.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields must be filled')),
      );
      return;
    }

    if (file_1 == false ||
        file_2 == false ||
        file_3 == false ||
        file_4 == false ||
        file_5 == false ||
        file_6 == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All documents must be uploaded')),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final body = jsonEncode({
      "Age": int.parse(_ageController.text),
      "Income": int.parse(_incomeController.text),
      "Home": _selectedHomeType,
      "Emp_length": int.parse(_selectedEmpLength),
      "Amount": int.parse(_amountController.text),
      "Default": _selectedLoan
    });
    try {
      final response = await http.post(
        apiUrl,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );
      final response2 = await http.post(apiUrl2,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"text": _purposeController.text}));
      var request = http.MultipartRequest('POST', apiUrl3);
      request.files
          .add(await http.MultipartFile.fromPath('image', _file1!.path));
      var streamedResponse = await request.send();
      var response3 = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200 ||
          response2.statusCode == 200 ||
          response3.statusCode == 200) {
        final data = jsonDecode(response.body);
        final data2 = jsonDecode(response2.body);
        final jsonResponse = json.decode(response3.body);
        print("API Response: $data");
        prediction = data['prediction'];
        prediction = data2['prediction'];
        setState(() {
          _status = jsonResponse['status'];
        });
        // You can show result or navigate
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Prediction: ${data['prediction'] ?? 'N/A'}")),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Prediction: ${data2['prediction'] ?? 'N/A'}")),
        );
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: ApplicationSubmission(
                  prediction: prediction,
                )));
      } else {
        print("API Error: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("API Error: ${response.statusCode}")),
        );
        print("API Error: ${response2.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("API Error: ${response2.statusCode}")),
        );
        setState(() {
          _status = "Verification failed: ${response3.statusCode}";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('CNIC Not Verified')),
          );
        });
      }
    } catch (e) {
      print("API Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Some thing went wrong")),
      );
    }

    if (!_acceptCondition) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please accept the terms and conditions')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      // Encode images to base64 strings
      final idFront = await _encodeFileToBase64(_file1);
      final idBack = await _encodeFileToBase64(_file2);
      final utility = await _encodeFileToBase64(_file3);
      final income = await _encodeFileToBase64(_file4);
      final purchase = await _encodeFileToBase64(_file5);
      final business = await _encodeFileToBase64(_file6);
      double score = calculateFicoScore(
        paymentHistory: 95,
        creditUtilization: 80,
        creditHistoryLength: 70,
        creditMix: 60,
        newCredit: 50,
      );
      String c_score = score.toString();
      await FirebaseFirestore.instance.collection('applications').doc(uid).set({
        'fullName': _fullNameController.text,
        'homeType': _selectedHomeType,
        'age': _ageController.text,
        'income': _incomeController.text,
        'empLength': _selectedEmpLength,
        'amount': _amountController.text,
        'creditScore': c_score,
        'timeforloan': _loanTime.text,
        'purpose': _purposeController.text,
        'asset': _assetlease.text,
        'availing loan': _loanController.text,
        'timestamp': FieldValue.serverTimestamp(),
        'idFront': idFront,
        'idBack': idBack,
        'utility': utility,
        'incomeproof': income,
        'purchase': purchase,
        'business': business,
      });
      await FirebaseFirestore.instance.collection('notifications').add({
        'uid': uid,
        'title': 'Application Submitted',
        'message': prediction == 1
            ? 'Your application was successfully submitted.'
            : 'Your application can not be submitted.',
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false, // Optional: used to mark as read later
      });
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: ApplicationSubmission(prediction: prediction)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submission failed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void initState() {
    super.initState();
    _loadUserProfileImage();
  }

  Future<void> _loadUserProfileImage() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists && doc.data()!['profileImage'] != null) {
      setState(() {
        _imageBytes = base64Decode(doc.data()!['profileImage']);
      });
    }
  }

  @override
  void dispose() {
    _homeTypeController.dispose();
    _empLengthController.dispose();
    _fullNameController.dispose();
    _ageController.dispose();
    _incomeController.dispose();
    _amountController.dispose();
    _purposeController.dispose();
    _loanController.dispose();
    _leaseduration.dispose();
    _assetlease.dispose();
    _loanTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ijara',
              style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: secondary),
            ),
            Text('Loan Portal',
                style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6A7E64))),
          ],
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 3.w),
              child: GestureDetector(
                child: CircleAvatar(
                  radius: 2.5.h,
                  backgroundImage:
                      _imageBytes != null ? MemoryImage(_imageBytes!) : null,
                  child: _imageBytes == null
                      ? Icon(Icons.person, size: 10.h, color: Colors.grey)
                      : null,
                  backgroundColor: Colors.indigo,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: EditProfile()));
                },
              )),
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: GestureDetector(
              child: CircleAvatar(
                radius: 2.5.h,
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: primary,
                ),
                backgroundColor: secondary,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: NotificationScreen()));
              },
            ),
          )
        ],
      ),
      backgroundColor: primary,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xFF6A7E64),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.h), topRight: Radius.circular(5.h))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: Text(
                      'Please upload The Following Documents to Apply for Loan',
                      style: GoogleFonts.poppins(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                          color: secondary),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SubHeadings(
                    title: 'Name:',
                  ),
                  ApplicationFields(
                    label: 'Full Name',
                    inputType: TextInputType.text,
                    controller: _fullNameController,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SubHeadings(
                    title: 'Home:',
                  ),
                  DropdownTextField(
                    label: 'Home Type',
                    dropdownItems: _homeTypes,
                    initialValue: _selectedHomeType,
                    controller: _homeTypeController,
                    onDropdownChanged: (value) {
                      setState(() {
                        _selectedHomeType = value;
                      });
                      print('Selected Home Type: $value');
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SubHeadings(
                    title: 'Age:',
                  ),
                  ApplicationFields(
                    label: 'Age',
                    inputType: TextInputType.number,
                    controller: _ageController,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SubHeadings(
                    title: 'Income:',
                  ),
                  ApplicationFields(
                    label: 'Income',
                    inputType: TextInputType.number,
                    controller: _incomeController,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SubHeadings(
                    title: 'Employment Length(months):',
                  ),
                  DropdownTextField(
                    label: 'Employment Length',
                    dropdownItems: _empLength,
                    initialValue: _selectedEmpLength,
                    controller: _empLengthController,
                    onDropdownChanged: (value) {
                      setState(() {
                        _selectedEmpLength = value;
                      });
                      print('Selected Employment Length: $value');
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SubHeadings(
                    title: 'Amount:',
                  ),
                  ApplicationFields(
                    label: 'Amount',
                    inputType: TextInputType.number,
                    controller: _amountController,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SubHeadings(
                    title: 'Loan Time(months):',
                  ),
                  ApplicationFields(
                    label: 'Time',
                    inputType: TextInputType.number,
                    controller: _loanTime,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SubHeadings(
                    title: 'Purpose:',
                  ),
                  ApplicationFields(
                    label: 'Purpose',
                    inputType: TextInputType.text,
                    controller: _purposeController,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SubHeadings(
                    title: 'Availing any Loan:',
                  ),
                  DropdownTextField(
                    label: 'Availing any Loan?',
                    dropdownItems: _availingLoan,
                    initialValue: _selectedLoan,
                    controller: _loanController,
                    onDropdownChanged: (value) {
                      setState(() {
                        _selectedLoan = value;
                      });
                      print('Selected Employment Length: $value');
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SubHeadings(
                    title: 'Asset to Lease:',
                  ),
                  ApplicationFields(
                    label: 'Asset',
                    inputType: TextInputType.text,
                    controller: _assetlease,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SubHeadings(
                    title: 'Lease Duration:',
                  ),
                  ApplicationFields(
                    label: 'Duration',
                    inputType: TextInputType.number,
                    controller: _leaseduration,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SubHeadings(title: 'Required Documents:'),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          FilesCard(
                              title: 'CNIC Front',
                              subtitle: _subtitle,
                              icon: Icons.add_photo_alternate_outlined,
                              fileType: 'image',
                              onFilePicked: (file, type) {
                                setState(() {
                                  _file1 = file;
                                  _subtitle = 'Uploaded';
                                  file_1 = true;
                                });
                              }),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          FilesCard(
                              title: 'Income Proof',
                              subtitle: _subtitle2,
                              icon: Icons.upload_file_outlined,
                              fileType: 'pdf',
                              onFilePicked: (file, type) {
                                setState(() {
                                  _file4 = file;
                                  _subtitle2 = 'Uploaded';
                                  file_2 = true;
                                });
                              }),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          FilesCard(
                              title: 'PurchasePlan',
                              subtitle: _subtitle5,
                              icon: Icons.upload_file_outlined,
                              fileType: 'pdf',
                              onFilePicked: (file, type) {
                                setState(() {
                                  _file5 = file;
                                  _subtitle5 = 'Uploaded';
                                  file_3 = true;
                                });
                              }),
                        ],
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Column(
                        children: [
                          FilesCard(
                              title: 'CNIC Back',
                              subtitle: _subtitle3,
                              icon: Icons.add_photo_alternate_outlined,
                              fileType: 'image',
                              onFilePicked: (file, type) {
                                setState(() {
                                  _file2 = file;
                                  _subtitle3 = 'Uploaded';
                                  file_4 = true;
                                });
                              }),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          FilesCard(
                              title: 'Utility Bill',
                              subtitle: _subtitle4,
                              icon: Icons.upload_file_outlined,
                              fileType: 'pdf',
                              onFilePicked: (file, type) {
                                setState(() {
                                  _file3 = file;
                                  _subtitle4 = 'Uploaded';
                                  file_5 = true;
                                });
                              }),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          FilesCard(
                              title: 'Business Plan',
                              subtitle: _subtitle6,
                              icon: Icons.upload_file_outlined,
                              fileType: 'pdf',
                              onFilePicked: (file, type) {
                                setState(() {
                                  _file6 = file;
                                  _subtitle6 = 'Uploaded';
                                  file_6 = true;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomCheckboxTile(
                    value: _acceptCondition,
                    onChanged: (value) {
                      setState(() {
                        _acceptCondition = value!;
                      });
                    },
                    title:
                        'I Confirm that all provided information is accurate',
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  // Center(
                  //   child: _isLoading
                  //       ? Container(
                  //           color: Colors.black.withOpacity(0.5),
                  //           child: Center(
                  //             child: CircularProgressIndicator(
                  //               valueColor:
                  //                   AlwaysStoppedAnimation<Color>(secondary),
                  //             ),
                  //           ),
                  //         )
                  //       : GestureDetector(
                  //           child: UserButton(
                  //             color: Color(0xffD3D3D3),
                  //             text: 'Submit',
                  //             text_color: primary,
                  //             height: 6,
                  //             width: 28,
                  //           ),
                  //           onTap: _submitApplication,
                  //         ),
                  // ),

                  Center(
                    child: Stack(
                      children: [
                        GestureDetector(
                          child: UserButton(
                            color: Color(0xffD3D3D3),
                            text: 'Submit',
                            text_color: primary,
                            height: 6,
                            width: 28,
                          ),
                          onTap: _submitApplication,
                        ),
                        if (_isLoading)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(secondary),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 3.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
