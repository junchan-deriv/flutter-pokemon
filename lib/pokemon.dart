import 'package:flutter/material.dart';
import 'package:pikachu_jump/main_game_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pokemon extends StatefulWidget {
  const Pokemon({Key? key}) : super(key: key);

  @override
  State<Pokemon> createState() => PokemonState();
}

class PokemonState extends State<Pokemon> with SingleTickerProviderStateMixin {
  late MainGameCubit _gameCubit;
  late AnimationController _animationController;
  late Animation _animation;
  @override
  void initState() {
    super.initState();
    _gameCubit = context.read<MainGameCubit>();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animationController.addListener(() {
      _gameCubit.pikachuHeight = _animation.value;
      setState(() {});
    });
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  void jump() {
    _animationController.reset();
    _animationController.forward().then(
      (value) {
        _animationController.reverse();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final height = size.height * 0.45;
    return Transform.translate(
      offset: Offset(0, -(height * _animation.value)),
      child: Container(
        margin: EdgeInsets.only(top: height),
        width: size.width * 0.22,
        height: size.height * 0.1,
        child: Image(
          image: AssetImage(_animation.value > 0
              ? "assets/imgs/jump.png"
              : "assets/imgs/stay.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
