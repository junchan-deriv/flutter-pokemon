import 'package:flutter/material.dart';
import 'package:pikachu_jump/main_game_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoneWidget extends StatefulWidget {
  const StoneWidget({Key? key}) : super(key: key);

  @override
  State<StoneWidget> createState() => _StoneWidgetState();
}

class _StoneWidgetState extends State<StoneWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late MainGameCubit _gameCubit;
  @override
  void initState() {
    super.initState();
    _gameCubit = context.read<MainGameCubit>();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100), value: 0);
    _animationController.addListener(() {
      _gameCubit.stonePosition = _animationController.value;
      setState(() {});
    });
    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final left = size.width * 0.7;
    return Row(
      children: [
        Transform.translate(
          offset: Offset(0, -size.height * 0.1),
          child: Container(
            margin: EdgeInsets.only(left: left * _animationController.value),
            width: size.width * 0.3,
            height: size.height * 0.2,
            child: const Image(
              image: AssetImage("assets/imgs/stone.png"),
              fit: BoxFit.fill,
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
