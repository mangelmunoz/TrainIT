
class User{

  String? _name;
  String? _birthday;
  String? _level;
  String? _weight;
  String? _height;

  Map toJson() => {
    'username': _name,
    'birthday':_birthday,
    'level': _level, 
    'weight': _weight,
    'height': _height,
  };

  set setName(name) => _name = name;
  get getName{return _name;}
  
  set setBirthday(birthday) => _birthday = birthday;
  get getBirthday{return _birthday;}

  set setLevel(level) => _level = level;
  get getLevel{return _level;}

  set setWeight(weight) => _weight = weight;
  get getWeight{return _weight;}

  set setHeight(height) => _height = height;
  get getHeight{return _height;}
}