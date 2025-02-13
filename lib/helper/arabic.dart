abstract class ArabicTerms {
  static const baabFatahaYaftahu = 'فَتَحَ';
  static const baabNasaraYansuru = 'نَصَرَ';
  static const baabSamiaYasmau = 'سَمِعَ';
  static const baabKarumaYakrumu = 'كَرُمَ';
  static const baabDarabaYadribu = 'ضَرَبَ';
  static const baabAlIfal = 'الْإِفْعَالْ';
  static const baabAlMufaala = 'اَلْمُفَاعَلَةُ';
  static const baabAlTafil = 'التَّفْعِيلُ';
  static const baabAlIftial = 'الاِفْتِعَال';

  static const maadi = 'ماضي';
  static const mudari = 'مضارع';
  static const baab = 'باب';
  static const meaning = 'معنى';
  static const masdar = 'المصدر';

  static const listOfBaabs = [
    baabFatahaYaftahu,
    baabNasaraYansuru,
    baabSamiaYasmau,
    baabKarumaYakrumu,
    baabDarabaYadribu,
    baabAlIfal,
    baabAlMufaala,
    baabAlTafil,
    baabAlIftial
  ];

  // Function to remove harakat (diacritics) from Arabic text
  static String removeHarakat(String input) {
    final harakatRegex = RegExp(r'[\u064B-\u065F\u0670]'); // Range of harakat Unicode characters
    return input.replaceAll(harakatRegex, '');
  }
}

