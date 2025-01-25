import 'dart:math';
import 'package:hive/hive.dart';

part 'ArabicVerb.g.dart';  // For Hive code generation
//flutter pub run build_runner build --delete-conflicting-outputs
@HiveType(typeId: 0)  // Unique ID for the class
class ArabicVerb extends HiveObject {
  @HiveField(0)
  String maadi;

  @HiveField(1)
  String mudari;

  @HiveField(2)
  String masdar;

  @HiveField(3)
  String baab;

  @HiveField(4)
  String bengaliMeaning;

  @HiveField(5)
  String exampleSentence;  // Example sentence for the verb

  @HiveField(6)
  int failCounter;  // For marking favorite verbs

  @HiveField(7)
  bool isFavorite;

  @HiveField(8)
  int? failHistory;

  ArabicVerb({
    required this.maadi,
    required this.mudari,
    required this.masdar,
    required this.baab,
    required this.bengaliMeaning,
    this.exampleSentence = '',
    this.isFavorite = false,
    this.failCounter = 0,
    this.failHistory = 0,
  });

  String pickRandomQuestion() {
    final List<String> properties = [
      maadi,
      mudari,
      masdar,
      bengaliMeaning,
    ];

    final Random random = Random();
    int randomIndex = random.nextInt(properties.length);

    return properties[randomIndex];
  }

  decreaseFailCount(){
    if(failCounter > 0){
      failCounter--;
    }
  }
}
