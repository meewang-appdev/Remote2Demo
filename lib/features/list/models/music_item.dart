import 'package:flutter/cupertino.dart';
import 'package:xml/xml.dart';

@immutable
class MusicItem {
  final String imageUrl;
  final String title;
  final String artist;

  const MusicItem({
    required this.imageUrl,
    required this.title,
    required this.artist,
  });

  // [수정] JSON 대신 XmlElement를 받아 객체를 생성하는 팩토리 생성자
  factory MusicItem.fromXmlElement(XmlElement element) {
    return MusicItem(
      imageUrl: element.findElements('image').first.innerText,
      title: element.findElements('title').first.innerText,
      artist: element.findElements('artist').first.innerText,
    );
  }
}