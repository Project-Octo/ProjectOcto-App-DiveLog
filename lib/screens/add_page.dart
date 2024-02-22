import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _maxDepthController = TextEditingController();
  final TextEditingController _totalBottomTimeController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  File? _videoFile;

  String _selectedType = 'Single Gas'; // Default type

  bool _isFormValid() {
    return _nameController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _maxDepthController.text.isNotEmpty &&
        _totalBottomTimeController.text.isNotEmpty;
  }

  Future<void> _upload() async {
    //Form 유효성 검사
    if (!_isFormValid()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Please fill all the required fields and select a video.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final storage =
        FirebaseStorage.instanceFor(bucket: "gs://diver-logbook-videos");
    print('storage: $storage');

    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    print('result: $result');
    if (result != null) {
      final filePath = result.files.single
          .path; // /data/user/0/com.example.octo_app/cache/file_picker/1000000018.mp4

      final fileName = filePath?.split('/').last;

      final ref = storage.ref();

      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;

      print(
          'filePath: $filePath'); // /data/user/0/com.example.octo_app/cache/file_picker/1000000018.mp4
      print('fileName: $fileName'); // 1000000018.mp4

      print(
          'ref: $ref'); // Reference(app: [DEFAULT], fullPath: uploads/1000000018.mp4)
      print(
          'File(filePath!): ${File(filePath!)}'); // File: '/data/user/0/com.example.octo_app/cache/file_picker/1000000018.mp4'
      print('_dateController: ${_dateController.text}');
      print('_locationController: ${_locationController.text}');
      print('UID: ${uid}');

      // 파일 업로드
      final newFileName =
          '${uid}_${_dateController.text}_${_locationController.text}.mp4'; // userId_date_location.mp4
      print('### newFileName: ${newFileName} ###');

      final task = ref.child(newFileName).putFile(File(filePath!));
      print('--------------------Upload started--------------------');

      // 업로드 진행 상황 모니터링
      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;

        print('Upload progress: $progress');
      });

      // 업로드 완료
      await task;
      print('Video uploaded successfully to Google Cloud Storage');
    } else {
      print('No file selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Dive Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );

                      if (selectedDate != null) {
                        _dateController.text =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                      }
                    },
                  ),
                ],
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.location_on_sharp)),
              ),
              DropdownButtonFormField(
                value: _selectedType,
                items:
                    ['Single Gas', 'Multi Gas', 'Gauge', 'Apnea Hunt', 'Apnea']
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Type', prefixIcon: Icon(Icons.anchor_sharp)),
              ),
              TextFormField(
                controller: _maxDepthController,
                decoration: const InputDecoration(
                    labelText: 'Max Depth (m)', prefixIcon: Icon(Icons.water)),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _totalBottomTimeController,
                decoration: const InputDecoration(
                    labelText: 'Total Bottom Time (min)',
                    prefixIcon: Icon(Icons.timer_outlined)),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                    labelText: 'Note', prefixIcon: Icon(Icons.edit_note_sharp)),
                maxLines: null,
              ),
              const SizedBox(height: 20.0),
              if (_videoFile != null)
                Text('Selected video: ${_videoFile!.path}'),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _upload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0077C8), // 색상 변경
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select Video & Upload',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
