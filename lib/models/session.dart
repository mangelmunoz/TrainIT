

class Session{

  String? _date;
  String? _exerciseName;
  int?    _repetitions;
  int?    _series;
  int?    _restTime;

  get getDate => _date;
  set setDate(date) => _date = date;

  get getExerciseName => _exerciseName;
  set setExerciseName(eName) => _exerciseName = eName;

  get getRepetitions => _repetitions;
  set setRepetitions( repetitions) => _repetitions = repetitions;

  get getSeries => _series;
  set setSeries( series) => _series = series;

  get getRestTime => _restTime;
  set setRestTime( restTime) => _restTime = restTime;
  
  Map toJson() => {
    'date': _date,
    'exercise_name': _exerciseName,
    'repetitions': _repetitions, 
    'series': _series,
    'restTime': _restTime,
  };

}