import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class FilesCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool flag;
  final String fileType; // 'image' or 'pdf'
  final void Function(File?, String fileType) onFilePicked;

  FilesCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.flag = false,
    required this.fileType,
    required this.onFilePicked,
  });

  @override
  State<FilesCard> createState() => _FilesCardState();
}

class _FilesCardState extends State<FilesCard> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      widget.onFilePicked(file, 'image');
    }
  }

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      widget.onFilePicked(file, 'pdf');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.fileType == 'image') {
          await _pickImage();
        } else if (widget.fileType == 'pdf') {
          await _pickPDF();
        }
      },
      child: Container(
        width: 45.w,
        decoration: BoxDecoration(
          color: Color(0xffD3D3D3),
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
          child: Row(
            children: [
              Icon(widget.icon, color: Colors.white, size: 4.h),
              SizedBox(width: 2.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.flag)
                    Text(
                      'Guarantor',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    widget.subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
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
}
