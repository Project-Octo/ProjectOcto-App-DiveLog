import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';

class AnimalsPage extends StatelessWidget {
  AnimalsPage({super.key});
  final List<String> fishList = [
    'Salmon',
    'mackerel',
    'octopus',
    'turtle',
  ];

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
                  borderRadius: BorderRadius.circular(8),
                  child: FutureBuilder<String>(
                    future: Future.delayed(
                      const Duration(seconds: 1),
                      () => _fetchImages(fishName),
                    ),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // 로딩 화면 표시
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        // 오류 처리
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        // 이미지 표시
                        return Image.network(
                          snapshot.data ?? "", // 데이터 없을 때 빈 문자열 사용
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  ),

                  // child: Image.asset(
                  //   'assets/images/$fishName.png',
                  //   height: 100.0,
                  //   width: 100.0,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                fishName,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showFishInfo(BuildContext context) {
    showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.5,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: _fetchFishInfo(fishName),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 데이터를 받아오는 중일 때 로딩 화면을 표시합니다.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                // 오류가 발생한 경우 오류를 표시합니다.
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                // 데이터를 정상적으로 받아왔을 때 화면을 구성합니다.
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    padding: const EdgeInsets.all(18),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
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
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        FutureBuilder<String>(
                          future: _fetchImages(fishName),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> imageSnapshot) {
                            if (imageSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              // 이미지를 불러오는 중일 때 로딩 화면을 표시합니다.
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (imageSnapshot.hasError) {
                              // 오류가 발생한 경우 오류를 표시합니다.
                              return Center(
                                child: Text('Error: ${imageSnapshot.error}'),
                              );
                            } else {
                              // 이미지를 정상적으로 불러왔을 때 이미지를 표시합니다.
                              return Image.network(
                                imageSnapshot.data ?? "",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            }
                          },
                        ),
                        MarkdownBody(
                          styleSheet: MarkdownStyleSheet(
                            textScaleFactor: 1.1,
                          ),
                          data: snapshot.data ?? '',
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  //물고기 사진 API
  Future<String> _fetchImages(String fishName) async {
    final parameters = {
      'q': fishName,
      'engine': 'google_images',
      'ijn': '0',
      'api_key':
          'cf7912d354898e1905347e40b7556b09240c1ed5b88eb41287d66c7b6e876fce'
    };

    final uri = Uri.https('serpapi.com', '/search', parameters);

    print('###########################################');
    print(uri);
    print('###########################################');

    final response = await http.get(uri);
    print('###########################################');
    print('await http get');
    print('###########################################');

    if (response.statusCode == 200) {
      print('###########################################');
      print('response.statusCode == 200');
      print('###########################################');
      final json = jsonDecode(response.body);
      if (json.containsKey('images_results') &&
          json['images_results'].isNotEmpty) {
        // 이미지 링크 추출
        final imageUrl = json['images_results'][0]['original'];
        return imageUrl;
      } else {
        throw Exception('Image not found');
      }
    } else {
      throw Exception(
          'Failed to load image. Status code: ${response.statusCode}');
    }
  }

  //물고기 정보 요청 API
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
      return response.body;
    } else {
      throw Exception('Failed to load fish info');
    }
  }
}
