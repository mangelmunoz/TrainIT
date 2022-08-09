
class Exercise{

  String?         _name;
  String?         _img;
  String?         _info_img;
  
  String?         _group;
  String?         _difficulty;
  List<dynamic>?  _muscles;
  List<dynamic>?  _explication;
  List<dynamic>?  _images;
  String?         _parameters;


  Exercise();

  get getName => _name;
  set setName(String? name) => _name = name;

  get getImg => _img;
  set setImg( img) => _img = img;

  get getInfoimg => _info_img;
  set setInfoimg( value) => _info_img = value;

  get getGroup => _group;
  set setGroup( group) => _group = group;

  get getDifficulty => _difficulty;
  set setDifficulty( difficulty) => _difficulty = difficulty;

  get getMuscles => _muscles;
  set setMuscles( muscles) => _muscles = muscles;

  get getExplication => _explication;
  set setExplication( explication) => _explication = explication;

  get getImages => _images;
  set setImages( images) => _images = images;

  get getParameters => _parameters;
  set setParameters( parameters) => _parameters = parameters;
  
  Map toJson() => {
        'name': _name,
        'img':_img,
        'info_img': _info_img, 
        'group': _group,
        'dificulty': _difficulty,
        'muscles': _muscles,
        'explication': _explication,
        'images': _images,
        'parameters': _parameters
      };

}