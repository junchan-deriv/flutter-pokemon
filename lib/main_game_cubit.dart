import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class MainGameState {
  int score = 0, highScore = 0;
  double pikachuHeight = 0;
  double stonePosition = 0;
  MainGameState();
  factory MainGameState.clone(MainGameState another) {
    var returnVal = MainGameState();
    returnVal.score = another.score;
    returnVal.highScore = another.highScore;
    returnVal.stonePosition = another.stonePosition;
    returnVal.pikachuHeight = returnVal.pikachuHeight;
    return returnVal;
  }
}

class MainGameCubit extends Cubit<MainGameState> {
  MainGameCubit() : super(MainGameState());
  int get score => state.score;
  double get pikachuHeight => state.pikachuHeight;
  double get stonePosition => state.stonePosition;
  set score(int val) {
    if (val < 0) {
      val = 0;
    }
    var updated = MainGameState.clone(state);
    updated.score = val;
    updated.highScore = max(updated.highScore, val);
    emit(updated);
  }

  bool _hit = false, _jump = false;
  set pikachuHeight(double val) {
    if (val > 0) {
      _hit = false;
    }
    _jump = val > 0;
    state.pikachuHeight = val;
  }

  set stonePosition(double val) {
    if (val < 0.48 || val > 0.52) {
      _hit = false;
    } else if (!_jump && !_hit) {
      _hit = true;
      score--;
    }
    state.stonePosition = val;
  }
}
