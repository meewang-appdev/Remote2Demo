import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../../models/music_item.dart';

abstract class MusicRepository {
  Future<List<MusicItem>> fetchMusicList();
}

class MusicRepositoryImpl implements MusicRepository {
  @override
  Future<List<MusicItem>> fetchMusicList() async {
    try {
      // [수정] 실제 HTTP GET 요청을 보내는 로직
      final response = await http.get(
        Uri.parse('http://10.0.35.212:8080/flutter/list.json'),
      ).timeout(const Duration(seconds: 5)); // 5초 타임아웃 설정

      if (response.statusCode == 200) {
        // [수정] 응답 본문을 UTF-8로 디코딩하고 XML로 파싱합니다.
        final document = XmlDocument.parse(utf8.decode(response.bodyBytes));
        final items = document.findAllElements('item');
        return items.map((node) => MusicItem.fromXmlElement(node)).toList();
      } else {
        // 서버에서 200 OK가 아닌 다른 상태 코드를 반환한 경우
        throw Exception('Failed to load music list from server (status code: ${response.statusCode})');
      }
    } catch (e) {
      // 네트워크 연결 오류, 타임아웃, 파싱 오류 등 모든 예외를 처리합니다.
      throw Exception('Failed to fetch music list: $e');
    }
  }
}

// class MusicRepositoryImpl implements MusicRepository {
//   @override
//   Future<List<MusicItem>> fetchMusicList() async {
//     // 실제 앱에서는 http.get(Uri.parse('http://.../list.json')) 등을 사용합니다.
//     // 여기서는 HTTP 요청과 응답을 시뮬레이션합니다.
//     await Future.delayed(const Duration(seconds: 1));
//
//     // [수정] 서버 응답을 시뮬레이션하는 JSON 문자열.
//     // 이미지 URL을 외부에서 접근 가능한 공용 URL로 변경했습니다.
//     const jsonString = '''
//       [
//         {"image":"http://10.0.35.212:8080/flutter/1111.png","title":"would you like something to do 1","artist":"kanttata&child 1"},
//         {"image":"http://10.0.35.212:8080/flutter/2222.png","title":"would you like something to do 2","artist":"kanttata&child 2"},
//         {"image":"http://10.0.35.212:8080/flutter/3333.png","title":"would you like something to do 3","artist":"kanttata&child 3"},
//         {"image":"https://placehold.co/150x150/ef4444/ffffff?text=Art+4","title":"would you like something to do 4","artist":"kanttata&child 4"},
//         {"image":"https://placehold.co/150x150/3b82f6/ffffff?text=Art+5","title":"would you like something to do 5","artist":"kanttata&child 5"},
//         {"image":"https://placehold.co/150x150/16a34a/ffffff?text=Art+6","title":"would you like something to do 6","artist":"kanttata&child 6"},
//         {"image":"https://placehold.co/150x150/ef4444/ffffff?text=Art+7","title":"would you like something to do 7","artist":"kanttata&child 7"},
//         {"image":"https://placehold.co/150x150/3b82f6/ffffff?text=Art+8","title":"would you like something to do 8","artist":"kanttata&child 8"},
//         {"image":"https://placehold.co/150x150/16a34a/ffffff?text=Art+9","title":"would you like something to do 9","artist":"kanttata&child 9"},
//         {"image":"https://placehold.co/150x150/ef4444/ffffff?text=Art+10","title":"would you like something to do 10","artist":"kanttata&child 10"}
//       ]
//     ''';
//
//     // JSON 문자열을 파싱하여 Dart 객체 리스트로 변환
//     final List<dynamic> jsonList = json.decode(jsonString);
//     return jsonList.map((jsonItem) => MusicItem.fromJson(jsonItem)).toList();
//   }
// }