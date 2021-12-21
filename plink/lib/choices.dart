import 'package:smart_select/smart_select.dart' show S2Choice;

List<S2Choice<String>> genders = [
  S2Choice<String>(value: 'm', title: "남성"), // 'male'
  S2Choice<String>(value: 'f', title: "여성"), // 'female'
  S2Choice<String>(value: 'o', title: "그 외"), // 'others'
];

List<Map<String, dynamic>> interests = [
  {
    'id': 'gold',
    'name': '골프',
    'brand': 'Samsung',
    'category': 'sports'
  },
  {
    'id': 'tennis',
    'name': '테니스',
    'brand': 'Nokia',
    'category': 'Budget Phone'
  },
  {
    'id': 'fitness',
    'name': '피트니스',
    'brand': 'Nokia',
    'category': 'Budget Phone'
  },
  {
    'id': 'bike',
    'name': '자전거',
    'brand': 'Xiaomi',
    'category': 'Mid End Phone'
  },
  {
    'id': 'eat',
    'name': '맛집투어',
    'brand': 'Samsung',
    'category': 'Mid End Phone'
  },
  {
    'id': 'talk',
    'name': '수다떨기',
    'brand': 'Xiaomi',
    'category': 'Mid End Phone'
  },
  {
    'id': 'chiken',
    'name': '치맥하기',
    'brand': 'Samsung',
    'category': 'Mid End Phone'
  },
  {
    'id': 'sing',
    'name': '노래방',
    'brand': 'Meizu',
    'category': 'Mid End Phone'
  },
  {
    'id': 'study',
    'name': '스터디',
    'brand': 'Meizu',
    'category': 'Mid End Phone'
  },
];

List<Map<String, dynamic>> features = [
  {
    'id': 'sk3',
    'name': '#유혹에약한편',
    'brand': 'Samsung',
    'category': 'Budget Phone'
  },
  {
    'id': 'n106',
    'name': '#걱정쟁이',
    'brand': 'Nokia',
    'category': 'Budget Phone'
  },
  {
    'id': 'n150',
    'name': '#섬세한편',
    'brand': 'Nokia',
    'category': 'Budget Phone'
  },
  {
    'id': 'r7a',
    'name': '#협조성이높음',
    'brand': 'Xiaomi',
    'category': 'Mid End Phone'
  },
  {
    'id': 'ga10s',
    'name': '#합리적인편',
    'brand': 'Samsung',
    'category': 'Mid End Phone'
  },
  {
    'id': 'rn7',
    'name': '#행동이굼뜸',
    'brand': 'Xiaomi',
    'category': 'Mid End Phone'
  },
  {
    'id': 'ga20s',
    'name': '#보수적인편',
    'brand': 'Samsung',
    'category': 'Mid End Phone'
  },
  {
    'id': 'mc9',
    'name': '#외로움을잘타는편',
    'brand': 'Meizu',
    'category': 'Mid End Phone'
  },
  {
    'id': 'm6',
    'name': '#생각이깊음',
    'brand': 'Meizu',
    'category': 'Mid End Phone'
  },
];