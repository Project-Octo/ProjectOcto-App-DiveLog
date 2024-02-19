import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';

class AnimalsPage extends StatelessWidget {
  final List<String> fishList = [
    'Salmon',
    'mackerel',
    'octopus',
    'turtle',
    '강동헌',
    '최정환',
    'octopus',
    'turtle'
  ]; //더미데이터

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: fishList.length,
        itemBuilder: (BuildContext context, int index) {
          return FishCard(
            fishName: fishList[index],
          );
        },
      ),
    );
  }
}

class FishCard extends StatelessWidget {
  final String fishName;

  const FishCard({Key? key, required this.fishName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFishInfo(context),
      child: Container(
        color: Colors.transparent,
        child: Card(
          elevation: 0.0,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8), // 각 모서리 radius 값 설정
                  child: Image.asset(
                    'assets/images/$fishName.png',
                    height: 100.0, // 이미지 높이 조정
                    width: 100.0, // 이미지 너비 조정
                    fit: BoxFit.cover, // 이미지가 컨테이너에 맞게 조정될 수 있도록 설정
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                fishName,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showFishInfo(BuildContext context) async {
    final fishInfo = await _fetchFishInfo(fishName);

    double deviceHeight = MediaQuery.of(context).size.height;
    double targetHeight = deviceHeight * 0.8; // 화면의 80%만 차지하도록 설정

    // ignore: use_build_context_synchronously
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: targetHeight,
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        fishName,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context), // 모달 바텀 시트 닫기
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Image.asset(
                    'assets/images/$fishName.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8.0),
                  MarkdownBody(
                    data: fishInfo,
                  ),
                  // Text(
                  //   fishInfo,
                  //   style: const TextStyle(fontSize: 16.0),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String> _fetchFishInfo(String fishName) async {
    final response = await http.post(
      Uri.parse(
          'https://asia-northeast3-turing-cell-410207.cloudfunctions.net/octo-species-info-ai'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'species': fishName,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body.runtimeType);
      return response.body;
    } else {
      throw Exception('Failed to load fish info');
    }
  }
}
