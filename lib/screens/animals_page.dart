import 'package:flutter/material.dart';

class AnimalsPage extends StatelessWidget {
  final List<String> fishList = [
    'salmon',
    'mackerel',
    'octopus',
    'turtle',
    'salmon',
    'mackerel',
    'octopus',
    'turtle'
  ]; //더미데이터

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/$fishName.png', // 이미지 경로는 해당 물고기의 이름과 일치하도록 가정합니다.
                width: 80.0,
                height: 80.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              fishName,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFishInfo(BuildContext context) async {
    // 물고기 정보를 서버에 요청하고 모달로 표시하는 로직 구현
    final fishInfo = await _fetchFishInfo(fishName);
    // ignore: use_build_context_synchronously
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fishName,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/$fishName.png', // 이미지 경로는 해당 물고기의 이름과 일치하도록 가정합니다.
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                fishInfo, // 서버로부터 받은 물고기 정보
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String> _fetchFishInfo(String fishName) async {
    // 서버로부터 물고기 정보를 가져오는 비동기 함수
    // 예를 들어, https://asia-northeast3-turing-cell-410207.cloudfunctions.net/octo-species-info-ai에 POST 요청을 보내고 응답을 처리합니다.
    // 이 부분은 서버가 완성된 후에 정확한 요청 방법에 맞게 수정되어야 합니다.
    // 여기서는 더미 데이터를 반환합니다.
    return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget libero ac odio tincidunt dapibus. Nullam vestibulum eleifend mauris, quis varius erat lobortis a.';
  }
}
