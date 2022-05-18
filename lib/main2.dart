import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectOptionBox(),
    );
  }
}

class SelectOptionBox extends StatefulWidget {
  const SelectOptionBox({Key? key}) : super(key: key);

  @override
  State<SelectOptionBox> createState() => _SelectOptionBoxState();
}

class _SelectOptionBoxState extends State<SelectOptionBox> {
  final endHour = 23;
  final starHour = 0;
  final currentHour = DateTime.now().hour;
  final currentMinute = DateTime.now().minute;
  List<int> _todayHours = [], _tomorowHours = [], _hours = [];
  var _minutes = SortedList<int>((a, b) => a.compareTo(b));
  int hourValue = DateTime.now().hour;
  int minutesValue = 0;
  String dateType = DateType.today.name;

  @override
  void initState() {
    super.initState();
    for (int i = currentHour; i <= endHour; i++) {
      _todayHours.add(i);
    }
    for (int i = starHour; i <= currentHour; i++) {
      _tomorowHours.add(i);
    }
    if (currentMinute < 30) {
      _minutes.add(30);
    } else {
      _todayHours.removeAt(0);
      _minutes.add(0);
      _minutes.add(30);
    }
    _hours = _todayHours;
    hourValue = _todayHours[0];
    minutesValue = _minutes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            DropdownButton<String>(
                value: dateType,
                items: DateType.values
                    .map<DropdownMenuItem<String>>(
                      (e) => DropdownMenuItem(
                        value: e.name,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    if (newValue == DateType.tomorow.name) {
                      _hours = _tomorowHours;
                    } else {
                      _hours = _todayHours;
                    }
                    dateType = newValue!;
                    if (!_hours.contains(hourValue)) {
                      hourValue = _hours[0];
                    } else {
                      if (newValue == DateType.tomorow.name) {
                        if (!_minutes.contains(0)) {
                          _minutes.add(0);
                        }
                        minutesValue = 0;
                        if (_minutes.contains(30)) {
                          _minutes.remove(30);
                        }
                      } else {
                        if (!_minutes.contains(30)) {
                          _minutes.add(30);
                        }
                        minutesValue = 30;
                        if (_minutes.contains(0)) {
                          _minutes.remove(0);
                        }
                      }
                    }
                  });
                }),
            DropdownButton<int>(
                value: hourValue,
                items: _hours
                    .map<DropdownMenuItem<int>>(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.toString().padLeft(2, '0'),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    hourValue = newValue!;
                    if (!_minutes.contains(30)) {
                      _minutes.add(30);
                    }
                    if (!_minutes.contains(0)) {
                      _minutes.add(0);
                    }
                    if (hourValue == currentHour) {
                      if (currentMinute > 30) {
                        if (dateType == DateType.today.name) {
                          if (_minutes.contains(30)) {
                            _minutes.remove(30);
                          }
                          minutesValue = 0;
                        }
                      } else {
                        if (dateType == DateType.today.name) {
                          if (_minutes.contains(0)) {
                            _minutes.remove(0);
                          }
                          minutesValue = 30;
                        } else {
                          if (_minutes.contains(30)) {
                            _minutes.remove(30);
                          }
                          minutesValue = 0;
                        }
                      }
                    }
                  });
                }),
            DropdownButton<int>(
                value: minutesValue,
                items: _minutes
                    .map<DropdownMenuItem<int>>(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.toString().padLeft(2, '0'),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    minutesValue = newValue!;
                  });
                })
          ],
        ),
      ),
    );
  }
}

enum DateType { today, tomorow }

class SortedList<E> extends DelegatingList<E> {
  int Function(E a, E b)? _compareFunction;

  List<E> get _listBase => super.toList();

  SortedList([int Function(E a, E b)? compareFunction]) : super(<E>[]) {
    this._compareFunction = compareFunction;
  }

  @override
  void add(E value) {
    super.add(value);
    sort(_compareFunction);
  }

  @override
  void addAll(Iterable<E> iterable) {
    super.addAll(iterable);
    sort(_compareFunction);
  }

  @override
  List<E> operator +(List<E> other) {
    var returnList = (_listBase + (other));
    returnList.sort(_compareFunction);
    return returnList;
  }
}
