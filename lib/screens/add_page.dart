import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// dart:async, dart:io, dart:ui 라이브러리 import
import 'dart:async';
// device_info_plus 플러그인 import
// import 'package:device_info_plus/device_info_plus.dart';
// 안드로이드 플랫폼 관련 import
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// // 로컬 알림 관련 import
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// shared_preferences 플러그인 import
// import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> _uploadConfig() async {
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
    //파일 선택
    final result = await FilePicker.platform.pickFiles(type: FileType.video);

    //storage 버캣 주소 설정
    final storage =
        FirebaseStorage.instanceFor(bucket: "gs://diver-logbook-videos");
    final ref = storage.ref();

    // Entry point

    if (result != null) {
      //파일 경로 설정
      final filePath = result.files.single.path;

      //userId 추출
      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;

      //파일 이름 지정(userId_date_S_E.mp4)
      final newFileName =
          '${uid}_${_dateController.text}_${_locationController.text}.mp4'; // userId_date_location.mp4

      // 파일 업로드
      // ignore: use_build_context_synchronously
      // showDialog(
      //   context: context,
      //   barrierDismissible: false, // 로딩창이 닫히지 않도록 설정
      //   builder: (context) => const Center(
      //     child: CircularProgressIndicator(),
      //   ),
      // );
      final task = ref.child(newFileName).putFile(File(filePath!));
      showDialog(
        context: context,
        barrierDismissible: false, // 로딩창이 닫히지 않도록 설정
        builder: (context) => Dialog(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CircularProgressIndicator(),
                const SizedBox(height: 20.0),
                StreamBuilder<TaskSnapshot>(
                  stream: task.snapshotEvents,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var progress = snapshot.data!.bytesTransferred /
                          snapshot.data!.totalBytes;
                      progress = progress * 100;
                      return Text('${progress.toStringAsFixed(2)}%');
                    } else {
                      return const Text('0.00%');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
      print('--------------------Upload started--------------------');

      // 업로드 진행 상황 모니터링
      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;

        print('Upload progress: $progress');
      });
      // 업로드 완료
      try {
        await task.then((p0) async {
          print('Video uploaded successfully to Google Cloud Storage');
          final response = await http.post(
            Uri.parse(
                'https://asia-northeast3-turing-cell-410207.cloudfunctions.net/octo-species-info-ai'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'video_name': newFileName,
            }),
          );
          if (response.statusCode == 200) {
            final aiResponseBody = response.body;
            print('AI response: $aiResponseBody');
          } else {
            throw Exception('Failed to request AI');
          }
        });
      } catch (e) {
        print('Error: $e');
        // 에러 발생 시 로딩창 닫고 에러 메시지 표시
        Navigator.pop(context); // 로딩창 닫기
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e')),
        );
        return;
      }
    } else {
      print('No file selected.');
    }
    Navigator.pop(context);
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
                    labelText: 'Location ex) 5S_110E',
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
                onPressed: _uploadConfig,
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
