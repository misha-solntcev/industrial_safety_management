class Header {
  String title;
  String url;
  List<Item> items;
  Header({
    required this.title,
    required this.url,
    required this.items,
  });
}

class Item {
  String title;
  String subtitle;
  Item({
    required this.title,
    required this.subtitle,
  });
}

final data = [
  Header(title: "Сосуд", url: '/tank', items: [
    Item(title: "Наименование", subtitle: "Сосуд ППЦЗ 12-01.00 000 СБ"),
    Item(title: "Заводской номер", subtitle: "0000134"),
    Item(title: "Регистрационый номер", subtitle: "11885"),
    Item(title: "Рабочее давление", subtitle: "1,6 Мпа (16 кгс/см2)"),
    Item(title: "Вместимость геометрическая", subtitle: "13,17 м3"),
    Item(title: "Вместимость полезная", subtitle: "11,19 м3"),
    Item(title: "Расчетный срок службы", subtitle: "20 лет"),
    Item(title: "Дата изготовления", subtitle: "24 марта 2005 года"),
    Item(title: "Дата регистрации", subtitle: "25 апреля 2016 года"),
  ]),
  Header(title: "Оборудование", url: '/equipment', items: [
    Item(title: "Наименование", subtitle: "Сосуд ППЦЗ 12-01.00 000 СБ"),
    Item(title: "Заводской номер", subtitle: "0000134"),
    Item(title: "Дата ввода в эксплуатацию", subtitle: "11885"),
    Item(title: "Расчетный срок службы", subtitle: "2 года"),
    Item(title: "Межповерочный интервал", subtitle: "6 месяцев"),
  ]),
  Header(title: "Персонал", url: '/staff', items: [
    Item(title: "ФИО", subtitle: "Носов Артем Петрович"),
    Item(title: "e-mail", subtitle: "art.brief@yandex.ru"),
    Item(title: "Телефон", subtitle: "8 950 072-29-29"),
  ]),
  Header(title: "Газовозы", url: '/gas_carriers', items: [],),
  Header(title: "Документы", url: '/documents', items: [],),
  Header(title: "Ростехнадзор", url: '/rtn', items: [],),
  Header(title: "ToDo", url: '/todo', items: [],),
];
